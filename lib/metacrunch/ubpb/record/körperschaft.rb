require_relative "./beziehungscodes"
require_relative "./element"

class Metacrunch::UBPB::Record::Körperschaft < Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    a: {
      "Körperschaft (unstrukturiert)" => :NW,
      "Konferenz (unstrukturiert)" => :NW,
      "Gebietskörperschaft (unstrukturiert)" => :NW
    },
    k: { "Körperschaft (strukturiert)" => :NW },
    e: { "Konferenz (strukturiert)" => :NW },
    g: { "Gebietsköperschaft (strukturiert)" => :NW },
    b: { "untergeordnete Körperschaft" => :W },
    n: { "Zählung" => :W },
    h: { "Zusatz" => :W },
    c: { "Ort der Konferenz" => :W },
    d: { "Datum der Konferenz" => :NW },
    x: { "allgemeine Unterteilung" => :W },
    z: { "geografische Unterteilung" => :W },
    "4": { "Beziehungscode" => :W },
    "9": { "GND Identifikationsnummer" => :NW },
    "3": { "Beziehungskennzeichnung in deutscher Sprache" => :W }, # wird nicht aktiv erfasst
    "5": { "Beziehungskennzeichnung in einer anderen Katalogisierungssprache" => :W } # wird nicht aktiv erfasst
  }

  private

  BEZIEHUNGSCODES = parent::BEZIEHUNGSCODES

  def default_value(options = {})
    if value = get("Körperschaft (strukturiert)", options) || get("Konferenz (strukturiert)", options) || get("Gebietsköperschaft (strukturiert)", options)
      is_conference = get("Konferenz (strukturiert)").present?

      composed_name =
      [
        value,
        get("untergeordnete Körperschaft", options)
      ]
      .flatten
      .compact
      .map.with_index do |element, index|
        additions =
        [
          [
            (get("Zählung", options) || [])[index],
            (is_conference && index == 0) ? get("Datum der Konferenz", options) : nil,
            (get("Ort der Konferenz", options) || [])[index]
          ]
          .compact
          .join(" : ")
          .presence,
          (get("Zusatz", options) || [])[index]
        ]
        .compact
        .join(", ")
        .presence

        element_with_fragments =
        [
          element,
          get("allgemeine Unterteilung", options),
          get("geografische Unterteilung", options)
        ]
        .flatten
        .compact
        .join(" / ")

        additions ? "#{element_with_fragments} (#{additions})" : element_with_fragments
      end
      .join(". ")

      relationship_designators =
      if [options[:include]].compact.flatten(1).include?("Beziehungskennzeichnungen")
        (get("Beziehungscode", options) || [])
        .map do |code|
          BEZIEHUNGSCODES[code.to_sym]
        end
        .uniq # there are examples with multiple equal relationship designators
        .join(", ")
        .presence
      end

      relationship_designators ? "#{composed_name} [#{relationship_designators}]" : composed_name
    elsif unstructured_name = get("Körperschaft (unstrukturiert)", options) || get("Konferenz (unstrukturiert)", options) || get("Gebietskörperschaft (unstrukturiert)", options)
      unstructured_name
    end
  end
end
