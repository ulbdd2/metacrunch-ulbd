require_relative "./element"

class Metacrunch::ULBD::Record::ManifestationstitelVonWeiterenVerkörpertenWerken < Metacrunch::ULBD::Record::Element
  SUBFIELDS = {
    a: { "Titel" => :NW },
    v: { "Verantwortlichkeitsangabe" => :NW },
    Z: { "Zuordnung zum originalschriftlichen Feld" => :NW }
  }
end
