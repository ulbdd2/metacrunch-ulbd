require_relative "../collection"
require_relative "../element/verantwortlichkeitsangabe"

class Metacrunch::UBPB::Record::Collection::Verantwortlichkeitsangaben < Metacrunch::UBPB::Record::Collection
  Verantwortlichkeitsangabe = parent.parent::Element::Verantwortlichkeitsangabe

  include Enumerable

  def initialize(document, options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    ind2 = include_superorders?(options) ? ["1", "2"] : ["1"]

    @elements = document.datafields("359", ind2: ind2).map do |datafield|
      Verantwortlichkeitsangabe.new(datafield)
    end
  end
end
