require "elasticsearch"
require "ox"
require "ruby-progressbar"

Dir.glob(File.join(__dir__, "..", "transformations", "mab2snr", "**", "*.rb"), &method(:require))

module Metacrunch
  module UBPB
    module Cli
      class Mab2SnrCommand < Metacrunch::Command
        include Metacrunch::Parallel::DSL

        def pre_perform
          @source_uri  = options[:source_uri]
          @target_uri  = options[:target_uri]

          @log_es      = options[:log_es]
          @log_mab     = options[:log_mab]
          @log_snr     = options[:log_snr]

          @bulk_size   = options[:bulk_size]
          @no_of_procs = options[:no_of_procs]
          @timestamp   = options[:timestamp].presence
          @id          = options[:id].presence
        end

        def perform
          source          = Metacrunch::Elasticsearch::Reader.new(@source_uri, query, log: @log_es)
          count           = source.count
          workingset_size = @bulk_size * 4
          progress        = ProgressBar.create(total: count.fdiv(workingset_size).ceil)

          shell.say "Processing #{count} records...", :green

          parallel(
            source.each.each_slice(workingset_size),
            in_processes: @no_of_procs,
            on_process_finished: -> { progress.increment }
          ) do |workingset|
            perform_workingset(workingset)
          end
        end

      private

        def perform_workingset(workingset)
          target = Metacrunch::Elasticsearch::Writer.new(@target_uri, autoflush: false, log: @log_es)

          workingset.each do |hit|
            id      = hit["_id"]
            mab_xml = hit["_source"]["data"]

            if mab_xml
              mab = Metacrunch::Mab2::Document.from_aleph_mab_xml(mab_xml)
              snr = Metacrunch::SNR.new

              transform(source: mab, target: snr, options: { source_id: id })

              puts snr.to_xml if @log_snr
              puts mab.to_xml if @log_mab
              target.write({id: id, data: Ox.dump(snr).force_encoding("utf-8")})
            else
              shell.say "Skipping empty mab with ID: #{id}", :red
            end
          end

          target.flush
        end

        def transform(source:, target:, options: {})
          transformer = Transformer.new
          transformer.register_helper(Transformations::MAB2SNR::Helpers::CommonHelper)

          transformer.source  = source
          transformer.target  = target
          transformer.options = options

          transformation_steps.each do |step|
            transformer.transform("Metacrunch::UBPB::Transformations::MAB2SNR::#{step}")
          end
        rescue => e
          puts e.message
          puts e.backtrace
          raise "Error while transforming #{id}."
        end

        def transformation_steps
          [
            "Id", "TitleId", "ZDBId", "Status", "CreationDate", "VolumeCount", "IsSuperorder",
            "TypeOfPublication", "TypeOfContent", "TypeOfMedia", "SelectionCode", "CreatorContributor",
            "Title", "Edition", "Publisher", "PlaceOfPublication", "DateOfPublication", "Description",
            "Toc", "TocLink", "ResourceLink", "ISBN", "ISSN", "DDC", "Abstract", "Language",
            "Subject", "Signature"
          ]
        end

        def query
          query = {
            fields: ["_source", "_timestamp"],
            sort: { _id: { order: "asc" } }
          }

          if @id.present?
            query[:query] = id_query
          elsif @timestamp.present?
            query[:query] = timestamp_query
          else
            query[:query] = match_all_query
          end

          query
        end

        def id_query
          { term: { _id: @id } }
        end

        def timestamp_query
          {
            filtered: {
              filter: {
                range: {
                  _timestamp: { gte: @timestamp }
                }
              }
            }
          }
        end

        def match_all_query
          { match_all: {} }
        end

      end
    end
  end
end