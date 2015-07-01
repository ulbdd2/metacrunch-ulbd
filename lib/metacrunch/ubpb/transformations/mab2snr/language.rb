module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Language < Metacrunch::Transformer::Step

          def perform
            target.add("control", "language", language) unless language.blank?
          end

        private

          def language
            @language ||= begin
              source.datafields("037", ind1: "b").subfields("a").first_value
            end
          end
        end
      end
    end
  end
end
