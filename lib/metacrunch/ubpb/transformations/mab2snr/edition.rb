module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Edition < Metacrunch::Transformer::Step

          def perform
            target.add("search",  "edition", edition)
            target.add("display", "edition", edition)
            target.add("sort",    "edition", edition.to_i) # TODO: Kann man besser machen
          end

        private

          def edition
            @edition ||= begin
              f403_1 = source.datafields("403", ind2: "1").subfields("a").first_value
              f403_2 = source.datafields("403", ind2: "2").subfields("a").first_value
              f407_1 = source.datafields("407", ind2: "1").subfields("a").first_value

              f403_1.presence || f403_2.presence || f407_1.presence
            end
          end

        end
      end
    end
  end
end
