module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class ISBN < Metacrunch::Transformer::Step

          def perform
            target.add("display", "isbn", display)
            target.add("search", "isbn", search)
          end

        private

          def display
            isbns
          end

          def search
            # TODO: Calculate ISBN10 from ISBN13
            # TODO: Maybe remove dashes (The search engine should handle that)
            isbns
          end

          def isbns
            @isbns ||= begin
              isbns = []

              # Primärformen
              isbns += source.datafields("540", ind1: :blank).subfields("a").values # ISBN formal nicht geprüft
              isbns += source.datafields("540", ind1: "a").subfields("a").values # ISBN formal richtig
              isbns += source.datafields("540", ind1: "b").subfields("a").values # ISBN formal falsch

              # Sekundärformen
              isbns += source.datafields("634", ind1: :blank).subfields("a").values # ISBN formal nicht geprüft
              isbns += source.datafields("634", ind1: "a").subfields("a").values # ISBN formal richtig
              isbns += source.datafields("634", ind1: "b").subfields("a").values # ISBN formal falsch

              isbns
            end
          end
        end
      end
    end
  end
end
