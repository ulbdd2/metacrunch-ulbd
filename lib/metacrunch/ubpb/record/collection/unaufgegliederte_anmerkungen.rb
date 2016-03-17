require_relative "../collection"
require_relative "../element/unaufgegliederte_anmerkung"

class Metacrunch::UBPB::Record::Collection::UnaufgegliederteAnmerkungen < Metacrunch::UBPB::Record::Collection
  UnaufgegliederteAnmerkung = parent.parent::Element::UnaufgegliederteAnmerkung

  include Enumerable

  def initialize(document, options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    ind2 = include_superorders?(options) ? ["1", "2"] : ["1"]

    @elements = document.datafields("501", ind2: ind2).map do |datafield|
      UnaufgegliederteAnmerkung.new(datafield)
    end
  end
end
