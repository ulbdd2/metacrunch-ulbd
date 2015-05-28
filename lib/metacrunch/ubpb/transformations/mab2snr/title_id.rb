module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class TitleId < Metacrunch::Transformer::Step

          def perform
            title_id = source.datafields("001", ind2: "1").subfields("a").first_value
            target.add("control", "title_id", title_id)
          end

        end
      end
    end
  end
end
