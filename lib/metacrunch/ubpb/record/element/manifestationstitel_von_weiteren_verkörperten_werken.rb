require_relative "../element"

class Metacrunch::UBPB::Record::Element::ManifestationstitelVonWeiterenVerkörpertenWerken < Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    a: { "Titel" => :NW },
    v: { "Verantwortlichkeitsangabe" => :NW },
    Z: { "Zuordnung zum originalschriftlichen Feld" => :NW }
  }
end
