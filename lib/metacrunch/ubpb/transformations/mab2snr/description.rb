module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Description < Metacrunch::Transformer::Step

          def perform
            target.add("search",  "description", descriptions)
            target.add("display", "description", descriptions)
          end

        private

          # TODO: Verläufe von Zeitschriften sollten ggf. in ein eigenes
          # Feld, oder?
          def descriptions
            @descriptions ||= begin
              descriptions = []

              # 405 - Erscheinungsverlauf von Zeitschriften
              descriptions += descriptions_for("405")
              # 522 - Teilungsvermerk bei fortlaufenden Sammelwerken
              descriptions += descriptions_for("522")
              # 523 - Erscheinungsverlauf von Monos
              descriptions += descriptions_for("523")
              # Sonstige 500er
              (501..519).each { |f| descriptions += descriptions_for("#{f}") }
              # 536 - Voraussichtlicher Erscheinungstermin
              descriptions += descriptions_for("536")
              # 537 - Redaktionelle Bemerkungen (bei Zeitschriften ignorieren)
              descriptions += descriptions_for("537") unless helper.is_journal?

              descriptions
            end
          end

        private

          def descriptions_for(field)
            descriptions = []

            source.datafields(field, ind2: "1").each do |datafield|
              a = datafield.subfields("a").first_value
              p = datafield.subfields("p").first_value

              descriptions << [p, a].compact.join(": ") if a || p
            end

            descriptions
          end

        end
      end
    end
  end
end
