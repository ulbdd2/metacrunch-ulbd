require_relative "../element"

class Metacrunch::UBPB::Record::Element::AngabeZumInhalt < Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    t: { "Titel" => :NW },
    r: { "Verantwortlichkeitsangabe" => :NW },
    Z: { "Zuordnung zum originalschriftlichen Feld" => :NW },
    a: { "unstruktirierte Angaben zu weiteren Titeln" => :NW }, # wird nicht aktiv erfasst
    p: { "einleitendes Präfix" => :NW }                         # wird nicht aktiv erfasst
  }
end
