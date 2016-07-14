require_relative "./element"

class Metacrunch::ULBD::Record::ArtDesInhalts < Metacrunch::ULBD::Record::Element
  SUBFIELDS = {
    a: { "Art des Inhalts" => :NW },
    x: { "allgemeine Unterteilung" => :W },
    z: { "geografische Unterteilung" => :W },
    y: { "chronologische Unterteilung" => :W },
    "2": { "Quelle" => :NW },                         # wird nicht aktiv erfasst
    "3": { "spezifische Angabe" => :NW },             # wird nicht aktiv erfasst
    "8": { "Feldverknüpfung und Reihenfolge" => :W }, # wird nicht aktiv erfasst
    "9": { "GND-Identifikationsnummer" => :NW }
  }

  private

  def default_value(options = {})
    get("Art des Inhalts", options)
  end
end
