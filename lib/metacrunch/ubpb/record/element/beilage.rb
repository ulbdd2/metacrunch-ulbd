require_relative "../element"

class Metacrunch::UBPB::Record::Element::Beilage < Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    p: { "Beziehungskennzeichnung" => :W },
    n: { "Bemerkung" => :W },
    a: {
      "Titel" => :NW,
      "Titel des in Beziehung stehenden Werkes" => :NW },
    "9": {
      "Identifikationsnummer" => :NW,
      "Identifikationsnummer des Datensatzes des in Beziehung stehenden Werkes" => :NW
    }
  }

  def get(*args)
    if (result = super).is_a?(Array)
      result.map { |element| element.gsub("--->", "").strip }
    else
      result.try(:gsub, "--->", "")
    end
  end

  private

  def default_value(options = {})
    [
      [
        get("Beziehungskennzeichnung", options).try(:first), # there are no real examples with more than one of it
        get("Bemerkung", options).try(:first)
      ]
      .compact
      .join(" ")
      .presence,
      get("Titel des in Beziehung stehenden Werkes", options)
    ]
    .compact
    .join(": ")
    .presence
  end
end
