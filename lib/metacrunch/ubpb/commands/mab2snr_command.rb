require "elasticsearch"
require "ox"
require "ruby-progressbar"

Dir.glob(File.join(__dir__, "..", "transformations", "mab2snr", "*.rb"), &method(:require))

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
        @timestamp   = options[:timestamp].presence
      end

      def perform
        source          = Metacrunch::Elasticsearch::Reader.new(@source_uri, query, log: @log)
        count           = source.count
        workingset_size = @bulk_size * 4
        progress        = ProgressBar.create(total: count.fdiv(workingset_size).ceil)

        shell.say "Processing #{count} records...", :green

        parallel(
          source.each.each_slice(workingset_size),
          in_processes: @no_of_procs,
          on_process_finished: -> { progress.increment}
        ) do |workingset|
          target = Metacrunch::Elasticsearch::Writer.new(@target_uri, autoflush: false, log: @log)

          workingset.each do |hit|
            id      = hit["_id"]
            mab_xml = hit["_source"]["data"]

            if mab_xml
              mab = Metacrunch::Mab2::Document.from_aleph_mab_xml(mab_xml)
              snr = Metacrunch::SNR.new

              transformer = Transformer.new(source: mab, target: snr, options: {source_id: id})
              transform(transformer)

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
        query = {
          fields: ["_source", "_timestamp"],
          sort: { _id: { order: "asc" } }
        }

        if @timestamp.present?
          query[:query] = {
            filtered: {
              filter: {
                range: {
                  _timestamp: {
                    gte: @timestamp
                  }
                }
              }
            }
          }
        else
          query[:query] = {
            match_all: {}
          }
        end

        query
      end

      def transform(transformer)
        transformer.transform(Transformations::MAB2SNR::Id)
        transformer.transform(Transformations::MAB2SNR::TitleId)
        transformer.transform(Transformations::MAB2SNR::Status)
        transformer.transform(Transformations::MAB2SNR::Authors)
      end

    end
  end
end
