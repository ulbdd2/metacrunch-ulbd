require "yaml"
require "elasticsearch"

module Metacrunch
  module UBPB
    class InitIndexCommand < Metacrunch::Command

      KNOWN_INDICIES = ["mab_xml", "snr"]

      def pre_perform
        @uri          = URI(options[:uri])
        @log          = options[:log]
        @override     = options[:override]

        unless KNOWN_INDICIES.include?(@uri.index)
          raise ArgumentError, "Unknown index name. One of #{KNOWN_INDICIES.join(', ')} required."
        end
      end

      def perform
        mapping = YAML.load(File.read(File.join(UBPB.root, "etc", "#{@uri.index}-es-mapping.yml")))

        if @override
          client.indices.delete(index: @uri.index)
        end

        client.indices.create(
          index: @uri.index,
          body: mapping
        )
      end

    private

      def client
        @client ||= ::Elasticsearch::Client.new(host: @uri.host, port: @uri.port, log: @log)
      end

    end
  end
end
