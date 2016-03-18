require_relative "../record"

class Metacrunch::UBPB::Record::Collection
  include Enumerable

  def initialize(datafields, options = {})
    @elements = datafields.map do |datafield|
      options[:element_class].new(datafield)
    end
  end

  def each
    return elements.each unless block_given?

    elements.each do |element|
      yield element
    end
  end

  def empty?
    elements.empty?
  end

  def elements
    @elements || []
  end
end
