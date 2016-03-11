require_relative "../beziehungscodes"
require_relative "../element"

class Metacrunch::UBPB::Record::Element::Körperschaft < Metacrunch::UBPB::Record::Element
  SUBFIELD_MAPPING = {
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

  BEZIEHUNGSCODES = parent.parent::BEZIEHUNGSCODES

  def normalized_name(options = {})
    if value = get("Körperschaft (strukturiert)") || get("Konferenz (strukturiert)") || get("Gebietsköperschaft (strukturiert)")
      is_conference = get("Konferenz (strukturiert)").present?

      composed_name =
      [
        value,
        get("untergeordnete Körperschaft")
      ]
      .flatten
      .compact
      .map.with_index do |element, index|
        additions =
        [
          [
            (get("Zählung") || [])[index],
            (is_conference && index == 0) ? get("Datum der Konferenz") : nil,
            (get("Ort der Konferenz") || [])[index]
          ]
          .compact
          .join(" : ")
          .presence,
          (get("Zusatz") || [])[index]
        ]
        .compact
        .join(", ")
        .presence

        element_with_fragments =
        [
          element,
          get("allgemeine Unterteilung"),
          get("geografische Unterteilung")
        ]
        .flatten
        .compact
        .join(" / ")

        additions ? "#{element_with_fragments} (#{additions})" : element_with_fragments
      end
      .join(". ")

      relationship_designators =
      if [options[:include]].compact.flatten(1).include?("Beziehungskennzeichnungen")
        (get("Beziehungscode") || [])
        .map do |code|
          BEZIEHUNGSCODES[code.to_sym]
        end
        .uniq # there are examples with multiple equal relationship designators
        .join(", ")
        .presence
      end

      relationship_designators ? "#{composed_name} [#{relationship_designators}]" : composed_name
    elsif unstructured_name = get("Körperschaft (unstrukturiert)") || get("Konferenz (unstrukturiert)") || get("Gebietskörperschaft (unstrukturiert)")
      unstructured_name
    end
  end
end
