require_relative "./element"

class Metacrunch::UBPB::Record::ManifestationstitelVonWeiterenVerkörpertenWerken < Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    a: { "Titel" => :NW },
    v: { "Verantwortlichkeitsangabe" => :NW },
    Z: { "Zuordnung zum originalschriftlichen Feld" => :NW }
  }
end
