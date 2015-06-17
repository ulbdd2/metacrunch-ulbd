module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Publisher < Metacrunch::Transformer::Step

          def perform
            target.add("display", "publisher", publishers)
            target.add("search",  "publisher", publishers)
          end

        private

          def publishers
            @publishers ||= begin
              f412_1 = source.datafields("412", ind2: "1").subfields("a").first_value
              f412_2 = source.datafields("412", ind2: "2").subfields("a").first_value
              f417_1 = source.datafields("417", ind2: "1").subfields("a").first_value
              f417_2 = source.datafields("417", ind2: "2").subfields("a").first_value

              f412 = f412_1.presence || f412_2.presence
              f417 = f417_1.presence || f417_2.presence
              # ... weitere Verleger in 418 ohne Ortsangabe ignorieren wir

              publishers = []
              publishers << f412 if f412.present?
              publishers << f417 if f417.present?

              publishers
            end
          end

        end
      end
    end
  end
end
