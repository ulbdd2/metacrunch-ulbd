require_relative "../ubpb"

class Metacrunch::UBPB::Record
  require_relative "./record/collection/körperschaften"
  require_relative "./record/collection/körperschaften_phrasenindex"
  require_relative "./record/collection/personen"
  require_relative "./record/collection/personen_der_nebeneintragungen"
  require_relative "./record/collection/personen_phrasenindex"
  require_relative "./record/collection/verantwortlichkeitsangaben"

  PROPERTIES = {
    "Körperschaften" => Collection::Körperschaften,
    "Körperschaften (Phrasenindex)" => Collection::KörperschaftenPhrasenindex,
    "Personen" => Collection::Personen,
    "Personen der Nebeneintragungen" => Collection::PersonenDerNebeneintragungen,
    "Personen (Phrasenindex)" => Collection::PersonenPhrasenindex,
    "Verantwortlichkeitsangaben" => Collection::Verantwortlichkeitsangaben
  }

  delegate :controlfield, :datafields, to: :@document

  def initialize(document)
    @document = document
  end

  def get(property, options = {})
    if klass = PROPERTIES[property]
      klass.new(@document, options)
    end
  end
end
