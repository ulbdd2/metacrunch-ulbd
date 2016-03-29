require_relative "./element"

class Metacrunch::UBPB::Record::BevorzugterTitelDesWerkes < Metacrunch::UBPB::Record::Element
  #
  # Unterfelder, Personen und Körperschaften betreffend, werden nicht berücksichtigt
  #
  SUBFIELDS = {
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

  private

  def default_value(options = {})
    include_options = [options[:include]].flatten(1).compact

    if include_options.include?("Überordnungen")
      [
        [
          get("Titel", options),
          get("Zählung", options)
        ]
        .compact
        .join(", ")
        .presence,
        get("Titel eines Teils", options) || get("Titel einer Abteilung", options)
      ]
      .compact
      .join(". ")
      .presence
    else
      (get("Titel eines Teils", options) || get("Titel einer Abteilung", options)).try(:first) || get("Titel", options)
    end
  end
end
