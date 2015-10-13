require "metacrunch/elasticsearch/index_creator"
require "metacrunch/elasticsearch/indexer"
require "metacrunch/elasticsearch/searcher"
require "metacrunch/file/reader"
require_relative "../cli"
require_relative "../transformations/mab_to_primo"
require_relative "../transformations/primo_to_elasticsearch"

class Metacrunch::UBPB::Cli::LoadIndex < Metacrunch::Command
  include Metacrunch::Parallel::DSL

  BULK_SIZE = 1000
  DEFAULT_MAPPING = {
    _id: { # http://elasticsearch-users.115913.n3.nabble.com/Range-for-id-td4025670.html
      index: "not_analyzed"
    },
    _timestamp: {
      enabled: true,
      store: true # not needed for query, just to be able to view it with fields: ["*"]
    },
    dynamic_templates: [
=begin
      {
        nested_fields: {
          match: "additional_data|relation|secondary_form_superorder|superorder_display",
          match_pattern: "regex",
          mapping: {
            type: "nested"
          }
        }
      },
=end
      {
        non_analyzed_searchable_fields: {
          match: "isbn|issn|ht_number|selection_code|signature",
          match_pattern: "regex",
          mapping: {
            index: "not_analyzed"
          }
        }
      },
      {
        facets: {
          match: ".+facet|erscheinungsform|delivery_category|materialtyp|inhaltstyp",
          match_pattern: "regex",
          mapping: {
            index: "not_analyzed"
          }
        }
      }
    ]
  }

  def call
    if params.empty?
      shell.say "No files found", :red
      exit(1)
    end

    default_mapping = DEFAULT_MAPPING.deep_dup
    logger = ::Logger.new(STDOUT)

    if user_given_default_mappping_filename = options[:default_mapping]
      user_given_default_mapping =
      if user_given_default_mappping_filename.end_with?(".json")

      elsif user_given_default_mappping_filename.end_with?(".yml")
        YAML.load_file(user_given_default_mappping_filename) 
      end

      merger = -> (key, old_value, new_value) do
        if old_value.is_a?(Array)
          old_value.concat([new_value].compact.flatten(1))
        elsif old_value.is_a?(Hash)
          old_value.merge(new_value, &merger)
        else
          new_value
        end
      end

      if user_given_default_mapping
        default_mapping
        .deep_stringify_keys!
        .deep_merge!(user_given_default_mapping.deep_stringify_keys, &merger)
      end
    end

    elasticsearch_index_creator = Metacrunch::Elasticsearch::IndexCreator.new({
      delete_existing_index: true,
      default_mapping: default_mapping,
      index: options[:index],
      logger: logger,
      url: options[:url]
    })

    elasticsearch_index_creator.call

    params
    .map! do |_param|
      _param.start_with?("http") ? _param : Dir.glob(File.expand_path(_param))
    end
    .flatten!

    number_of_processes = options[:number_of_processes] || 0 # disables multiprocessing
    mab_to_primo = Metacrunch::UBPB::Transformations::MabToPrimo.new
    primo_to_elasticsearch = Metacrunch::UBPB::Transformations::PrimoToElasticsearch.new

    Parallel.each(params, in_processes: number_of_processes) do |_param|
=begin
      if _param.start_with?("http")
        _url = _param.sub(URI(_param).path, "")
        _index, _type = URI(_param).path.split("/").map(&:presence).compact

        elasticsearch_reader = Metacrunch::Elasticsearch::Searcher.new(index: _index, type: _type, url: _url)
      end
=end

      reader = Metacrunch::File::Reader.new(filename: _param)
      elasticsearch_indexer = Metacrunch::Elasticsearch::Indexer.new({
        "id_accessor": -> (item) { item["id"] },
        "index": options[:index],
        "logger": logger,
        "type": options[:type],
        "url": options[:url]
      })

      reader.each_slice(BULK_SIZE) do |_bulk|
        _bulk.map! do |_file|
          mab_to_primo_result = mab_to_primo.call(_file.content)
          decode_json!(mab_to_primo_result)
          primo_to_elasticsearch.call(mab_to_primo_result)
        end

        elasticsearch_indexer.call(_bulk)
      end
    end
  end
  alias_method :perform, :call

  private

  def decode_json!(object)
    case object
    when Array
      object.map! do |_value|
        decode_json!(_value)
      end
    when Hash
      object.each do |_key, _value|
        object[_key] = decode_json!(_value)
      end
    when String
      if object.start_with?("{") && object.end_with?("}")
        JSON.parse(object)
      else
        object
      end
    else
      object
    end
  end
end
