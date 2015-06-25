module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Toc < Metacrunch::Transformer::Step

          def perform
            target.add("search",  "toc", toc)
          end

        private

          def toc
            source.datafields("TXT").map do |datafield|
              datafield.subfields("a").first_value
            end.join(" ")
          end

        end
      end
    end
  end
end
