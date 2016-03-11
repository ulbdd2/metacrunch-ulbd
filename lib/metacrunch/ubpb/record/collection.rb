require_relative "../record"

class Metacrunch::UBPB::Record::Collection
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
