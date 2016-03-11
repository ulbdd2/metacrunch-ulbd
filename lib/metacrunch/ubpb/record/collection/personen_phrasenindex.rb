require_relative "../collection"
require_relative "../element/person"

class Metacrunch::UBPB::Record::Collection::PersonenPhrasenindex < Metacrunch::UBPB::Record::Collection
  Person = parent.parent::Element::Person

  include Enumerable

  def initialize(document, options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    ind2 = include_superorders?(options) ? ["1", "2"] : ["1"]

    @elements =
    document.datafields("PPE", ind2: ind2).map do |datafield|
      Person.new(datafield)
    end
  end
end
