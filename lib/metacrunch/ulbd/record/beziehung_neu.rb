require_relative "./element"

class Metacrunch::ULBD::Record::BeziehungNeu < Metacrunch::ULBD::Record::Element
  SUBFIELDS = {
    i: { "Beziehungskennzeichnung" => :W },
    a: { "Geistiger Schoepfer" => :NW },
    c: { "Identifizierender Zusatz" => :NW},
    t: {
      "Titel" => :NW,
      "Titel der in Beziehung stehenden Ressource" => :NW 
    },
    b: { "Ausgabevermerk" => :NW},
    d: { "Erscheinungsvermerk" => :NW},
    g: { "in Beziehung stehende Teile" => :W},
    h: { "Physische Beschreibung" => :NW},
    k: { "Angaben zur Reihe" => :W},
    m: { "Materialspezifische Angaben" => :NW},
    n: { "Bemerkung" => :W },
    o: { "Weiterer Identifikator" => :W},
    r: { "Reportnummer" => :W},
    s: { "Werktitel" => :NW},
    u: { "Standardnummer für Forschungsberichte" => :NW},
    x: { "ISSN" => :NW},
    y: { "CODEN" => :NW},
    z: { "ISBN" => :W},
    #"4": { "Beziehung in codierter Form" => :NW},
    "9": {
      "Identifikationsnummer" => :NW,
      "Identifikationsnummer des Datensatzes der in Beziehung stehenden Ressource" => :NW
    },
    Z: { "Zuordnung zum originalschriftlichen Feld" => :NW }
  }

  def get(*args)
    if (result = super).is_a?(Array)
      result.map { |element| sanitize(element) }
    else
      sanitize(result)
    end
  end

  private

  def default_value(options = {})
   [
    [
     [
      [ 
      [
        get("Beziehungskennzeichnung").try(:first), # there are no real examples with more than one of it
        #get("Bemerkung").try(:first)
      ]
      .compact
      .join(" ")
      .presence,
      get("Geistiger Schoepfer")
    ]
    .compact
    .join(": ")
    .presence,
    get("Identifizierender Zusatz")
   ]
   .compact
   .join(". - ")
   .presence,
    get("Titel der in Beziehung stehenden Ressource")
    ]
    .compact
    .join(": ")
    .presence,
    get("Ausgabevermerk"),
    get("Erscheinungsvermerk"),
    get("in Beziehung stehende Teile"),
    get("Physische Beschreibung"),
    get("Angaben zur Reihe"),
    get("Materialspezifische Angaben"),
    get("Bemerkung"),
    get("Weiterer Identifikator"),
    get("Reportnummer"),
    get("Werktitel"),
    get("Standardnummer für Forschungsberichte"),
    get("ISSN"),
    get("CODEN"),
    get("ISBN"),
    #get("Beziehung in codierter Form")
    ]
    .compact
    .join(". - ")
    .presence
    .try do |result|
    sanitize(result)
    end
  end

  def sanitize(value)
    if value
      value
      .gsub("--->", ":")
      .gsub(/\.\s*\:/, ".:")
      .gsub(/:*\s*:/, ":")
      .strip
    end
  end
end
