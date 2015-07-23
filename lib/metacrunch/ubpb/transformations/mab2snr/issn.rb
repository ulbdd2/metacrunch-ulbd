module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class ISSN < Metacrunch::Transformer::Step

          def perform
            target.add("display", "issn", display)
            target.add("search", "issn", search)
          end

        private

          def display
            issns
          end

          def search
            # TODO: Maybe remove dashes (The search engine should handle that)
            issns
          end

          def issns
            @issns ||= begin
              issns = []

              issns += source.datafields("542", ind1: :blank).subfields("a").values # ISSN formal nicht geprüft
              issns += source.datafields("542", ind1: "a").subfields("a").values # ISSN formal richtig
              issns += source.datafields("542", ind1: "b").subfields("a").values # ISSN formal falsch

              # ... weitere ISSN für Fortlaufende Sammelewerke
              issns += source.datafields("545", ind1: :blank).subfields("a").values # ISSN formal nicht geprüft
              issns += source.datafields("545", ind1: "a").subfields("a").values # ISSN formal richtig
              issns += source.datafields("545", ind1: "b").subfields("a").values # ISSN formal falsch

              # Sekundärformen
              issns += source.datafields("635", ind1: :blank).subfields("a").values # ISSN formal nicht geprüft
              issns += source.datafields("635", ind1: "a").subfields("a").values # ISSN formal richtig
              issns += source.datafields("635", ind1: "b").subfields("a").values # ISSN formal falsch

              issns.uniq
            end
          end
        end
      end
    end
  end
end
