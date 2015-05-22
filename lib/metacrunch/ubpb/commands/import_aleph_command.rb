module Metacrunch
  module UBPB
    class ImportAlephCommand < Metacrunch::Command

      def pre_perform
        @uri         = options[:uri]
        @log         = options[:log]
        @bulk_size   = options[:bulk_size]
        @no_of_procs = options[:no_of_procs]
      end

      def perform
        if params.empty?
          shell.say "No files found", :red
        else
          Parallel.each(params, in_processes: @no_of_procs) do |file|
            shell.say("Processing file #{file}", :green)
            import_files(file)
          end
        end
      end

    private

      def import_files(files)
        elasticsearch = Metacrunch::Elasticsearch::Writer.new(@uri, bulk_size: @bulk_size, log: @log)

        file_reader = Metacrunch::FileReader.new(files)
        file_reader.each do |file|
          mab = file.contents.force_encoding("utf-8")
          id  = get_aleph_id(mab)

          elasticsearch.write({id: id, data: mab})
        end

        elasticsearch.close
      end

      def get_aleph_id(mab)
        id = mab.match(/<identifier>aleph-publish:(\d+)<\/identifier>/){ |m| m[1] }
        raise RuntimeError, "Document has no ID." unless id

        "PAD_ALEPH#{id}"
      end

    end
  end
end
