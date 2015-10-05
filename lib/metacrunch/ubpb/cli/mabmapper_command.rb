require "metacrunch/file/reader"
require "metacrunch/file/writer"
require "nokogiri"
require_relative "../cli"
require_relative "../transformations/mab_to_primo"

class Metacrunch::UBPB::Cli::MabmapperCommand < Metacrunch::Command
  include Metacrunch::Parallel::DSL

  def call
    if params.empty?
      shell.say "No files found", :red
      exit(1)
    end

    filenames = params.map { |_param| Dir.glob(File.expand_path(_param)) }.flatten
    number_of_processes = options[:number_of_processes] || 0 # disables multiprocessing
    transformation = Metacrunch::UBPB::Transformations::MabToPrimo.new

    Parallel.each(filenames, in_processes: number_of_processes) do |_filename|
      file_reader = Metacrunch::File::Reader.new(filename: _filename)
      output_file_name = File.join(options["output"], File.basename(_filename))
      file_writer = Metacrunch::File::Writer.new(output_file_name)

      file_reader.each do |_file|
        file_writer.write(
          content: hash_to_xml(transformation.call(_file.content)),
          entry_name: _file.entry_name
        )
      end

      file_writer.close
    end
  end
  alias_method :perform, :call

  private

  def hash_to_xml(hash)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.document do
        hash.each_pair do |_key, _values|
          if _values.present? || _values == false
            if _values.is_a?(Array)
              _values.each do |_value|
                xml.send("#{_key.downcase}_", _value)
              end
            else
              xml.send("#{_key.downcase}_", _values)
            end
          end
        end
      end
    end

    builder.to_xml
  end
end
