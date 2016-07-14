require_relative "./element"

class Metacrunch::ULBD::Record::ErweiterterDatenträgertyp < Metacrunch::ULBD::Record::Element
  SUBFIELDS = {
    a: { "Datenträgertyp" => :NW },
    x: { "allgemeine Unterteilung" => :W },
    z: { "geografische Unterteilung" => :W },
    y: { "chronologische Unterteilung" => :W },
    "2": { "Quelle" => :NW },                         # wird nicht aktiv erfasst
    "3": { "spezifische Angabe" => :NW },             # wird nicht aktiv erfasst
    "8": { "Feldverknüpfung und Reihenfolge" => :W }, # wird nicht aktiv erfasst
    "9": { "GND-Identifikationsnummer" => :NW }
  }

  def get(property = nil, options = {})
    if property.is_a?(Hash)
      options = property
      property = nil
    end

    property ? super : normalized_value(options)
  end

  def normalized_value(options = {})
    # mangels Beispielen für Datenträgertypen mit Unterteilung aktuell erstmal trivial
    get("Datenträgertyp")
  end
end
