require "active_support"
require "active_support/core_ext"
require "metacrunch/mab2/document"
require "metacrunch/transformator/transformation"
require_relative "../transformations"
require_relative "../../ubpb/record"

class Metacrunch::ULBD::Transformations::MabToVufind < Metacrunch::Transformator::Transformation
  require_directory "#{File.dirname(__FILE__)}/mab_to_vufind"

  # @param [String] source repesenting a MAB document in Aleph MAB XML format
  # @param [Hash] options
  # @option options [Hash] :target
  #
  # @return [Hash] transformation result
  def call(source, options = {})
    document = Metacrunch::Mab2::Document.from_aleph_mab_xml(source)
    record = Metacrunch::UBPB::Record.new(document)
    options[:target] ||= {}

    super(record, options)
  end

  sequence [
    AddId,
    AddHtNumber
  ]
end
