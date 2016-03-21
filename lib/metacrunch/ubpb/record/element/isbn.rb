require_relative "../element"

class Metacrunch::UBPB::Record::Element::ISBN < Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    a: { "ISBN ohne Textzusätze" => :NW },
    b: { "Einbandart und Preis" => :NW }
  }

  def get(property = nil, options = {})
    if property.is_a?(Hash)
      options = property
      property = nil
    end

    property ? super : get("ISBN ohne Textzusätze", options)
  end
end
