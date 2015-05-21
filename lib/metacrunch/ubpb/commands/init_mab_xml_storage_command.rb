require "yaml"
require "elasticsearch"

module Metacrunch
  module UBPB
    class InitMabXmlStorageCommand < Metacrunch::Command

      INDEX_NAME = "mab_xml"

      def pre_perform
        @uri = URI(options[:uri])
        @log = false
        @override = options[:override]
      end

      def perform
        mapping = YAML.load(File.read(File.join(UBPB.root, "etc", "mab-xml-es-mapping.yml")))

        if @override
          client.indices.delete(index: INDEX_NAME)
        end

        client.indices.create(
          index: INDEX_NAME,
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
