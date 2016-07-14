require_relative "./abgekürzte_funktionsbezeichnungen"
require_relative "./beziehungscodes"
require_relative "./element"

class Metacrunch::ULBD::Record::Person < Metacrunch::ULBD::Record::Element
  SUBFIELDS = {
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

  private

  ABGEKÜRZTE_FUNKTIONSBEZEICHNUNGEN = parent::ABGEKÜRZTE_FUNKTIONSBEZEICHNUNGEN
  BEZIEHUNGSCODES = parent::BEZIEHUNGSCODES

  def default_value(options = {})
    include_options = [options[:include]].flatten(1).compact

    if name_strukturiert = get("Name (strukturiert)", options)
      name_mit_zählung_und_zusätzen =
      [
        [
          name_strukturiert,
          get("Zählung", options)
        ]
        .compact
        .join(" "),
        [
          get("Beiname", options),
          get("Gattungsname", options),
          get("Territorium", options),
          get("Titulatur", options)
        ]
        .uniq
        .join(", ")
        .presence
      ]
      .compact
      .join(", ")

      # es kann mehr als eine geben
      beziehungskennzeichnungen =
      if include_options.include?("Beziehungskennzeichnungen")
        (get("Beziehungscode", options) || [])
        .map do |code|
          BEZIEHUNGSCODES[code.to_sym]
        end
        .uniq # there are examples with multiple equal relationship designators
        .join(", ")
        .presence
      end

      # es kann nur eine geben
      funktionsbezeichnung =
      if include_options.include?("Funktionsbezeichnung") || include_options.include?("ausgeschriebene Funktionsbezeichnung")
        if funktionsbezeichnung_in_eckigen_klammern = get("Funktionsbezeichnung in eckigen Klammern", options)
          funktionsbezeichnung = funktionsbezeichnung_in_eckigen_klammern[/[^\[\]]+/]

          if include_options.include?("ausgeschriebene Funktionsbezeichnung")
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
    elsif unstructured_name = get("Name (unstrukturiert)", options)
      unstructured_name
    end
  end
end
