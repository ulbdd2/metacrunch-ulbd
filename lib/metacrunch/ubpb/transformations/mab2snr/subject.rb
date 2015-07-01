module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Subject < Metacrunch::Transformer::Step

          def perform
            target.add("search", "subject", subjects) unless subjects.blank?
            # TODO: Display?
          end

        private

          def subjects
            @subjects ||= begin
              subjects = []

              # TODO: Sollte man 740 wirklich mit aufnehmen?
              # TODO: Sollte man sich lieber auf Sachschlagworte beschränken?

              ["710", "711", "740"].each do |field|
                subjects += split(source.datafields(field).subfields("a").values)
              end

              # TODO: Was ist mit dem Feld 902
              # TODO: Was mit weiteren Schlagworten aus PSW

              subjects.uniq
            end
          end

          # Bricht Ketten auf und räumt etwas auf
          # Beispiel aus 740: New York (N.Y.)--Social life and customs--20th century--Fiction.
          def split(subjects)
            subjects.inject([]) do |memo, subject_or_subject_chain|
              memo += subject_or_subject_chain.split("--").map do |subject|
                unless subject.blank?
                  subject.strip.gsub(/\.\Z/, "")
                end
              end
            end.compact
          end

        end
      end
    end
  end
end
