require_relative "../abgekürzte_funktionsbezeichnungen"
require_relative "../beziehungscodes"
require_relative "../element"

class Metacrunch::UBPB::Record::Element::Person < Metacrunch::UBPB::Record::Element
  SUBFIELD_MAPPING = {
    a: { "Name (unstrukturiert)" => :NW },
    p: { "Name (strukturiert)" => :NW },
    n: { "Zählung" => :NW },
    c: {
      "Beiname" => :NW,
      "Gattungsname" => :NW,
      "Territorium" => :NW,
      "Titulatur" => :NW
    },
    d: {
      "Lebensdaten" => :NW,
      "Wirkungsdaten" => :NW
    },
    b: { "Funktionsbezeichnung in eckigen Klammern" => :NW }, # RAK
    "4": { "Beziehungscode" => :W },
    "9": { "GND Identifikationsnummer" => :NW },
    "3": { "Beziehungskennzeichnung in deutscher Sprache" => :W }, # wird nicht aktiv erfasst
    "5": { "Beziehungskennzeichnung in einer anderen Katalogisierungssprache" => :W } # wird nicht aktiv erfasst
  }

  ABGEKÜRZTE_FUNKTIONSBEZEICHNUNGEN = parent.parent::ABGEKÜRZTE_FUNKTIONSBEZEICHNUNGEN
  BEZIEHUNGSCODES = parent.parent::BEZIEHUNGSCODES
  
  def normalized_name(options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    options[:omit] = [options[:omit]].compact.flatten(1)

    if name_strukturiert = get("Name (strukturiert)")
      name_mit_zählung_und_zusätzen =
      [
        [
          name_strukturiert,
          get("Zählung")
        ]
        .compact
        .join(" "),
        [
          get("Beiname"),
          get("Gattungsname"),
          get("Territorium"),
          get("Titulatur")
        ]
        .uniq
        .join(", ")
        .presence
      ]
      .compact
      .join(", ")

      # es kann mehr als eine geben
      beziehungskennzeichnungen =
      if options[:include].include?("Beziehungskennzeichnungen")
        (get("Beziehungscode") || [])
        .map do |code|
          BEZIEHUNGSCODES[code.to_sym]
        end
        .uniq # there are examples with multiple equal relationship designators
        .join(", ")
        .presence
      end

      # es kann nur eine geben
      funktionsbezeichnung =
      if options[:include].include?("Funktionsbezeichnung") || options[:include].include?("ausgeschriebene Funktionsbezeichnung")
        if funktionsbezeichnung_in_eckigen_klammern = get("Funktionsbezeichnung in eckigen Klammern")
          funktionsbezeichnung = funktionsbezeichnung_in_eckigen_klammern[/[^\[\]]+/]

          if options[:include].include?("ausgeschriebene Funktionsbezeichnung")
            if ausgeschriebene_funktionsbezeichnung = ABGEKÜRZTE_FUNKTIONSBEZEICHNUNGEN[funktionsbezeichnung]
              ausgeschriebene_funktionsbezeichnung
            else
              funktionsbezeichnung
            end
          else
            funktionsbezeichnung
          end
        end
      end

      if beziehungskennzeichnungen || funktionsbezeichnung
        "#{name_mit_zählung_und_zusätzen} [#{beziehungskennzeichnungen || funktionsbezeichnung}]"
      else
        name_mit_zählung_und_zusätzen
      end
    elsif unstructured_name = get("Name (unstrukturiert)")
      unstructured_name
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
