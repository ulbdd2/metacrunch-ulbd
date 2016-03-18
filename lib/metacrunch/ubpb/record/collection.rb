require_relative "../record"

class Metacrunch::UBPB::Record::Collection
  include Enumerable

  def initialize(document, tags, element_class, options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    ind1 = options[:ind1]
    ind2 = options[:ind2] || (include_superorders?(options) ? ["1", "2"] : "1")

    @elements =
    tags.map do |tag|
      document.datafields("#{tag}", ind1: ind1, ind2: ind2).map do |datafield|
        element_class.new(datafield)
      end
    end
    .flatten
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

  def include_superorders?(options)
    (options[:include] || []).include?("Überordnungen")
  end
end
