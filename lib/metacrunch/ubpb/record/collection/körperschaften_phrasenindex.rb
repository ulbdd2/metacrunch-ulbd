require_relative "../collection"
require_relative "../element/körperschaft"

class Metacrunch::UBPB::Record::Collection::KörperschaftenPhrasenindex < Metacrunch::UBPB::Record::Collection
  Körperschaft = parent.parent::Element::Körperschaft

  include Enumerable

  def initialize(document, options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    ind2 = include_superorders?(options) ? ["1", "2"] : ["1"]

    @elements =
    document.datafields("PKO", ind2: ind2).map do |datafield|
      Körperschaft.new(datafield)
    end
  end
end
