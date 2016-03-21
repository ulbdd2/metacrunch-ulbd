require_relative "../collection"
require_relative "../element/isbn"

class Metacrunch::UBPB::Record::Collection::ISBNs < Metacrunch::UBPB::Record::Collection
  ISBN = parent.parent::Element::ISBN

  def initialize(datafields, options = {})
    include_options_values = [options[:include]].compact.flatten(1)
    ind1 = ["a"]

    if include_options_values.include?("formal nicht geprüft")
      ind1 << "-"
    end

    if include_options_values.include?("formal falsch")
      ind1 << "b"
    end

    datafields = datafields.select do |datafield|
      ind1.include?(datafield.ind1)
    end

    super(datafields, options.reverse_merge(element_class: ISBN))
  end
end
