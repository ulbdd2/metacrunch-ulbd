require_relative "../ubpb"

class Metacrunch::UBPB::Record
  require_relative "./record/angabe_zum_inhalt"
  require_relative "./record/art_des_inhalts"
  require_relative "./record/bevorzugter_titel_des_werkes"
  require_relative "./record/beziehung"
  require_relative "./record/erweiterter_datenträgertyp"
  require_relative "./record/generisches_element"
  require_relative "./record/isbn"
  require_relative "./record/körperschaft"
  require_relative "./record/manifestationstitel_von_weiteren_verkörperten_werken"
  require_relative "./record/person"

  DATAFIELDS = [
    { tags: ["064"], ind1: ["a"], accessor: "Arten des Inhalts",                                    type: ArtDesInhalts },
    { tags: ["064"], ind1: ["b"], accessor: "erweiterte Datenträgertypen",                          type: ErweiterterDatenträgertyp },
    { tags: (100..196).step(4),   accessor: "Personen",                                             type: Person },
    { tags: (200..296).step(4),   accessor: "Körperschaften",                                       type: Körperschaft },
    { tags: ["303"], ind1: ["-"], accessor: "bevorzugte Titel des Werkes",                          type: BevorzugterTitelDesWerkes },
    { tags: ["303"], ind1: ["t"], accessor: "in Beziehung stehende Werke",                          type: BevorzugterTitelDesWerkes },
    { tags: ["334"],              accessor: "allgemeine Materialbenennungen",                       type: GenerischesElement },
    { tags: ["359"],              accessor: "Verantwortlichkeitsangaben",                           type: GenerischesElement },
    { tags: ["362"],              accessor: "Manifestationstitel von weiteren verkörperten Werken", type: ManifestationstitelVonWeiterenVerkörpertenWerken },
    { tags: ["359"],              accessor: "Verantwortlichkeitsangaben",                           type: GenerischesElement },
    { tags: ["501"],              accessor: "unaufgegliederte Anmerkungen",                         type: GenerischesElement },
    { tags: ["521"],              accessor: "Angaben zum Inhalt",                                   type: AngabeZumInhalt },
    { tags: ["526"],              accessor: "Titel von rezensierten Werken",                        type: Beziehung },
    { tags: ["527"],              accessor: "andere Ausgaben",                                      type: Beziehung },
    { tags: ["528"],              accessor: "Titel von Rezensionen",                                type: Beziehung },
    { tags: ["529"],              accessor: "Beilagen",                                             type: Beziehung },
    { tags: ["530"],              accessor: "übergeordnete Einheiten der Beilage",                  type: Beziehung },
    { tags: ["531"],              accessor: "Vorgänger",                                            type: Beziehung },
    { tags: ["533"],              accessor: "Nachfolger",                                           type: Beziehung },
    { tags: ["534"],              accessor: "sonstige Beziehungen",                                 type: Beziehung },
    { tags: ["540"],              accessor: "ISBNs",                                                type: ISBN },
    { tags: (800..824).step(6),   accessor: "Personen der Nebeneintragungen",                       type: Person },
    { tags: ["PKO"],              accessor: "Körperschaften (Phrasenindex)",                        type: Körperschaft },
    { tags: ["PPE"],              accessor: "Personen (Phrasenindex)",                              type: Person },
  ]

  delegate :controlfield, :datafields, to: :@document

  def initialize(document)
    @document = document
    @properties = {}

    DATAFIELDS.each do |entry|
      entry[:tags]
      .to_a
      .map do |tag|
        document.datafields(tag.to_s, { ind1: entry[:ind1] }.compact)
      end
      .try do |datafield_sets|
        datafield_sets.map do |datafield_set|
          datafield_set.map do |datafield|
            entry[:type].new(datafield)
          end
        end
        .flatten(1)
      end
      .try do |objects|
        if accessor = entry[:accessor]
          @properties[accessor] = objects
        end
      end
    end
  end

  def get(accessor, options = {})
    if objects = @properties[accessor]
      objects.select do |object|
        object.selected?(options)
      end
    end
  end
end
