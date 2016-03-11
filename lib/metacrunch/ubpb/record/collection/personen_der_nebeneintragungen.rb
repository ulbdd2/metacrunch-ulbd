require_relative "../collection"
require_relative "../element/person"

class Metacrunch::UBPB::Record::Collection::PersonenDerNebeneintragungen < Metacrunch::UBPB::Record::Collection
  Person = parent.parent::Element::Person

  include Enumerable

  def initialize(document, options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    ind2 = include_superorders?(options) ? ["1", "2"] : ["1"]

    @elements =
    (800..824).step(6).map do |tag|
      document.datafields("#{tag}", ind2: ind2).map do |datafield|
        Person.new(datafield)
      end
    end
    .flatten
  end
end
