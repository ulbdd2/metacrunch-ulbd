require "elasticsearch"
require "ox"
require "ruby-progressbar"

module Metacrunch
  module UBPB
    class Mab2SnrCommand < Metacrunch::Command
      include Metacrunch::Parallel::DSL

      def pre_perform
        @source_uri  = options[:source_uri]
        @target_uri  = options[:target_uri]
        @log         = options[:log]
        @bulk_size   = options[:bulk_size]
        @no_of_procs = options[:no_of_procs]
      end

      def perform
        source   = Metacrunch::Elasticsearch::Reader.new(@source_uri, query, log: @log)
        count    = source.count
        progress = ProgressBar.create(total: count.fdiv(@bulk_size).ceil)

        shell.say "Processing #{count} records...", :green

        parallel(
          source.each.each_slice(@bulk_size),
          in_processes: @no_of_procs,
          on_process_finished: -> { progress.increment}
        ) do |bulk|
          target = Metacrunch::Elasticsearch::Writer.new(@target_uri, autoflush: false, bulk_size: @bulk_size, log: @log)

          bulk.each do |hit|
            id      = hit["_id"]
            mab_xml = hit["_source"]["data"]

            if mab_xml
              mab = Metacrunch::Mab2::Document.from_aleph_mab_xml(mab_xml)
              snr = Metacrunch::SNR.new

              transformer = Transformer.new(source: mab, target: snr, options: {})
              normalize(id, transformer)

              target.write({id: id, data: Ox.dump(snr).force_encoding("utf-8")})
            else
              shell.say "Skipping empty mab with ID: #{id}", :red
            end
          end

          target.flush
        end
      end

    private

      def query
        {
          query: {
            match_all: {}
          }
        }
      end

      def normalize(id, transformer)
        transformer.transform do
          target.add("control", "id", id)
        end

        transformer.transform do
          names  = source.datafields("100", ind1: "-").subfields("p").values
          names += source.datafields("104", ind1: "a").subfields("p").values
          target.add("search", "authors", names)
        end
      end

    end
  end
end
