require_relative "./element"

class Metacrunch::ULBD::Record::AngabeZumInhalt < Metacrunch::ULBD::Record::Element
  SUBFIELDS = {
    t: { "Titel" => :NW },
    r: { "Verantwortlichkeitsangabe" => :NW },
    Z: { "Zuordnung zum originalschriftlichen Feld" => :NW },
    a: { "unstruktirierte Angaben zu weiteren Titeln" => :NW }, # wird nicht aktiv erfasst
    p: { "einleitendes Präfix" => :NW }                         # wird nicht aktiv erfasst
  }

  private

  def default_value(options = {})
    [
      get("einleitendes Präfix"),
      get("Titel") || get("unstruktirierte Angaben zu weiteren Titeln")
    ]
    .compact
    .join(" ")
    .presence
  end
end
