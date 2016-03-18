require_relative "../element"

class Metacrunch::UBPB::Record::Element::Titel < Metacrunch::UBPB::Record::Element
  #
  # Unterfelder Personen und Körperschaften betreffend, werden nicht berücksichtigt
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

  def get(property = nil, options = {})
    if property.is_a?(Hash)
      options = property
      property = nil
    end

    property ? super : normalized_title(options)
  end

  def normalized_title(options = {})
    options[:include] = [options[:include]].flatten(1).compact
    options[:omit] = [options[:omit]].compact.flatten(1)

    if options[:include].include?("Überordnungen")
      [
        [
          get("Titel"),
          get("Zählung")
        ]
        .compact
        .join(", ")
        .presence,
        get("Titel eines Teils") || get("Titel einer Abteilung")
      ]
      .compact
      .join(". ")
      .presence
    else
      (get("Titel eines Teils") || get("Titel einer Abteilung")).try(:first) || get("Titel")
    end
    .try do |result|
      if options[:omit].include?("sortierirrelevante Worte")
        result.gsub(/<<[^>]+>>/, "")
      else
        result.gsub(/<|>/, "")
      end
    end
    .try(:strip)
  end
end
