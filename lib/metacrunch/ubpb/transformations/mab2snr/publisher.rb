module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Publisher < Metacrunch::Transformer::Step

          def perform
            target.add("display", "publisher",             publishers)
            target.add("display", "places_of_publication", places_of_publication)
            target.add("search",  "publisher",             publishers)
            target.add("search",  "places_of_publication", places_of_publication)
          end

        private

          def publishers
            unless @publishers
              f412_1 = source.datafields("412", ind2: "1").subfields("a").first_value
              f412_2 = source.datafields("412", ind2: "2").subfields("a").first_value
              f417_1 = source.datafields("417", ind2: "1").subfields("a").first_value
              f417_2 = source.datafields("417", ind2: "2").subfields("a").first_value

              f412 = f412_1.presence || f412_2.presence
              f417 = f417_1.presence || f417_2.presence
              # ... weitere Verleger in 418 ohne Ortsangabe ignorieren wir

              @publishers = []
              @publishers << f412 if f412.present?
              @publishers << f417 if f417.present?
            end

            @publishers
          end

          def places_of_publication
            unless @places
              f410_1 = source.datafields("410", ind2: "1").subfields("a").first_value
              f410_2 = source.datafields("410", ind2: "2").subfields("a").first_value
              f415_1 = source.datafields("415", ind2: "1").subfields("a").first_value
              f415_2 = source.datafields("415", ind2: "2").subfields("a").first_value

              f410 = f410_1.presence || f410_2.presence
              f415 = f415_1.presence || f415_2.presence

              @places = []
              @places << f410 if f410.present?
              @places << f415 if f415.present?
            end

            @places
          end

        end
      end
    end
  end
end
