require_relative "../helpers"
require_relative "person_relationship_designator"

module Metacrunch::UBPB::Transformations::MabToPrimo::Helpers::Datafield1XX
  def datafield_1xx(options = {})
    options[:ind2] ||= ["1", "2"]

    values =
    (100..196).step(4).map do |f|
      source.datafields("#{f}", options).map do |_field|
        [
          _field.subfields("a").value,   # Name
          _field.subfields("p").value,   # Familienname, Vorname/persönlicher_name,
          _field.subfields("n").value,   # Zählung
          _field.subfields("c").value,   # Beiname, Gattungsname, Ttitulatur, Territorium,
          _field.subfields("b").value || # Funktionsbezeichnung in eckigen Klammern
          begin                          # (mapped) Beziehungscodes
            german_shortcuts =
            _field.subfields("4").values.map do |_value|
              "[#{Metacrunch::UBPB::Transformations::MabToPrimo::Helpers::PersonRelationshipDesignator.to_german_shortcut(_value)}]"
            end

            if german_shortcuts.present?
              german_shortcuts.first # for now, we only take the first one ... can be changed later
            end
          end
        ]
        .compact
        .presence
        .try(:join, " ")
      end
    end
    .flatten
    .compact

    Struct.new(:values) do
      def value
        self.values.presence.try(:join, " ")
      end
    end
    .new(values)
  end
end
