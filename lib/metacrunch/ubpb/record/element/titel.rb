require_relative "../element"

class Metacrunch::UBPB::Record::Element::Titel < Metacrunch::UBPB::Record::Element
  #
  # Unterfelder Personen und Körperschaften betreffend, werden nicht berücksichtigt
  #
  SUBFIELD_MAPPING = {
    t: { "Titel" => :NW },
    h: { "Zusatz" => :W },
    m: { "Besetzung" => :W },
    n: { "Zählung" => :W },
    o: { "Angabe eines Musikarrangements" => :NW },
    u: {
      "Titel eines Teils" => :W,
      "Titel einer Abteilung" => :W
    },
    r: { "Tonart" => :W },
    s: { "Version" => :W },
    x: { "mehrgliedrige Benennung" => :W },
    v: { "Bemerkung" => :W },
    z: {
      "Bezeichnungen" => :W,
      "Teilausgabe" => :W,
      "Gattung" => :W
    },
    f: { "Erscheinungsjahr" => :NW },
    i: { "Relationsterm" => :W },
    "4": { "Beziehungscode" => :W },
    "9": { "GND-Identifikationsnummer" => :NW },
    Z: { "Zuordnung zum originalschriftlichen Feld" => :NW }
  }


end
