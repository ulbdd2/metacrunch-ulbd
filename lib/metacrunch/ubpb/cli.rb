module Metacrunch
  module UBPB
    module Cli
      require_relative "./cli/import_aleph_command"
      require_relative "./cli/init_index_command"
      require_relative "./cli/load_index"
      require_relative "./cli/mab2snr_command"
      require_relative "./cli/mabmapper_command"
    end
  end
end

Metacrunch::Cli.setup("ubpb", "Commands for University Library Paderborn") do |r|
  #
  # Init elasticsearch index for storage
  #
  r.register(Metacrunch::UBPB::Cli::InitIndexCommand) do |c|
    c.name  "init_index"
    c.usage "init_index"
    c.desc  "Init ElasticSearch for MAB XML storage"

    c.option :uri,
      desc: "ElasticSearch URI",
      type: :string,
      required: true
    c.option :override,
      desc: "Override if exists (ALL DATA WILL BE LOST)",
      type: :boolean,
      default: false
    c.option :log,
      desc: "Turn on ElasticSearch logging",
      type: :boolean,
      default: false
  end

  #
  # Load Aleph MAB XML into elastic search
  #
  r.register(Metacrunch::UBPB::Cli::ImportAlephCommand) do |c|
    c.name  "import_aleph"
    c.usage "import_aleph FILES..."
    c.desc  "Import Aleph MAB XML files into ElasticSearch"

    c.option :uri,
      desc: "ElasticSearch URI for the (target) MAB XML data",
      type: :string,
      default: "elasticsearch://localhost/mab_xml/document"
    c.option :log,
      desc: "Turn on ElasticSearch logging",
      type: :boolean,
      default: false
    c.option :bulk_size,
      desc: "Bulk size when writing to ElasticSearch",
      type: :numeric,
      default: 250
    c.option :no_of_procs,
      desc: "Number of parallel processes",
      aliases: "-n",
      type: :numeric,
      default: 1
  end

  #
  # Normalizes MAB to SNR
  #
  r.register(Metacrunch::UBPB::Cli::Mab2SnrCommand) do |c|
    c.name  "mab2snr"
    c.usage "mab2snr"
    c.desc  "Normalize MAB into SNR"
    c.option :source_uri,
      desc: "ElasticSearch URI for the (source) MAB XML data",
      type: :string,
      default: "elasticsearch://localhost/mab_xml/document"
    c.option :target_uri,
      desc: "ElasticSearch URI for the (target) SNR data",
      type: :string,
      default: "elasticsearch://localhost/snr/document"
    c.option :log_es,
      desc: "Turn on ElasticSearch logging",
      type: :boolean,
      default: false
    c.option :log_mab,
      desc: "Log MAB XML record",
      type: :boolean,
      default: false
    c.option :log_snr,
      desc: "Log SNR (XML) record",
      type: :boolean,
      default: false
    c.option :bulk_size,
      desc: "Bulk size when reading/writing to ElasticSearch",
      type: :numeric,
      default: 250
    c.option :no_of_procs,
      desc: "Number of parallel processes",
      aliases: "-n",
      type: :numeric,
      default: 1
    c.option :timestamp,
      desc: "ElasticSearch date/time expression to query only MAB records that changed since given timestamp",
      type: :string
    c.option :id,
      desc: "Only process the MAB record with the given id",
      type: :string
  end

  #
  # mabmapper
  #
  r.register(Metacrunch::UBPB::Cli::MabmapperCommand) do |c|
    c.name  "mabmapper"
    c.usage "mabmapper"
    c.desc  "Normalize MAB"
    c.option :output,
      desc: "Output directory",
      required: true,
      aliases: "-o",
      type: :string
    c.option :silent,
      desc: "Do not output anything on the console",
      aliases: "-s",
      type: :boolean,
      default: false
    c.option :number_of_processes,
      desc: "Number of parallel processes",
      aliases: "-n",
      type: :numeric
  end

  #
  # load_index
  #
  r.register(Metacrunch::UBPB::Cli::LoadIndex) do |c|
    c.name  "load_index"
    c.usage "load_index"
    c.desc "load_index"
    c.option :default_mapping,
      desc: "Default mapping",
      aliases: "-d",
      type: :string
    c.option :url,
      desc: "Elasticsearch url",
      aliases: "-u",
      type: :string,
      default: "http://localhost:9200"
    c.option :delete_existing_index,
      desc: "Delete existing index",
      aliases: "-f",
      type: :boolean
    c.option :index,
      desc: "Name of the index to index to",
      required: true,
      aliases: "-i",
      type: :string
    c.option :type,
      desc: "Type of documents indexed",
      required: true,
      aliases: "-t",
      type: :string
    c.option :number_of_processes,
      desc: "Number of parallel processes",
      aliases: "-n",
      type: :numeric
  end
end
