require_relative "./element"

class Metacrunch::UBPB::Record::Beziehung < Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    p: { "Beziehungskennzeichnung" => :W },
    n: { "Bemerkung" => :W },
    a: {
      "Titel" => :NW,
      "Titel der in Beziehung stehenden Ressource" => :NW 
    },
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
        get("Beziehungskennzeichnung").try(:first), # there are no real examples with more than one of it
        get("Bemerkung").try(:first)
      ]
      .compact
      .join(" ")
      .presence,
      get("Titel der in Beziehung stehenden Ressource")
    ]
    .compact
    .join(": ")
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
