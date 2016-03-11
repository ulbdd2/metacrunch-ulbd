require_relative "../element"

class Metacrunch::UBPB::Record::Element::Verantwortlichkeitsangabe < Metacrunch::UBPB::Record::Element
  SUBFIELD_MAPPING = {
    a: { "nicht spezifiziert" => :NW }
  }
end
