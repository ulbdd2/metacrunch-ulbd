require_relative "../element"

class Metacrunch::UBPB::Record::Element::TitelVonRezensiertemWerk < Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    p: { "Präfix" => :NW },
    a: {
      "Titel" => :NW,
      "Titel des rezensierten Werkes" => :NW },
    "9": {
      "Identifikationsnummer" => :NW,
      "Identifikationsnummer des Bezugswerkes" => :NW
    }
  }

  private

  def default_value(options = {})
    [
      get("Präfix"),
      get("Titel des rezensierten Werkes")
    ]
    .compact
    .join(" ")
    .presence
  end
end
