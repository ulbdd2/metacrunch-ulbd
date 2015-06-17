module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class PlaceOfPublication < Metacrunch::Transformer::Step

          def perform
            target.add("display", "place_of_publication", places_of_publication)
            target.add("search",  "place_of_publication", places_of_publication)
          end

        private

          def places_of_publication
            @places ||= begin
              f410_1 = source.datafields("410", ind2: "1").subfields("a").first_value
              f410_2 = source.datafields("410", ind2: "2").subfields("a").first_value
              f415_1 = source.datafields("415", ind2: "1").subfields("a").first_value
              f415_2 = source.datafields("415", ind2: "2").subfields("a").first_value

              f410 = f410_1.presence || f410_2.presence
              f415 = f415_1.presence || f415_2.presence

              places = []
              places << f410 if f410.present?
              places << f415 if f415.present?

              places
            end
          end

        end
      end
    end
  end
end
