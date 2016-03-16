require_relative "../collection"
require_relative "../element/bevorzugter_titel_des_werkes"

class Metacrunch::UBPB::Record::Collection::BevorzugteTitelDesWerkes < Metacrunch::UBPB::Record::Collection
  Titel = parent.parent::Element::Titel

  include Enumerable

  def initialize(document, options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    ind1 = ["-"]

    if options[:include].include?("in der Manifestation verkörperte Werke") || options[:include].include?("in Beziehung stehende Werke")
      ind1 << "t"
    end

    records = document.datafields("303", ind1: ind1, ind2: "1")
    superorders = document.datafields("303", ind1: ind1, ind2: "2")

    @elements = records.map do |record|
      if options[:include].include?("Überordnungen")
        Titel.new(record, superorders: superorders)
      else
        Titel.new(record)
      end
    end
  end
end
