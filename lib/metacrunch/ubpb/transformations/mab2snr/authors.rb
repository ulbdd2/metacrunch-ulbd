module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Authors < Metacrunch::Transformer::Step

          def perform
            names  = source.datafields("100", ind1: "-").subfields("p").values
            names += source.datafields("104", ind1: "a").subfields("p").values
            target.add("search", "authors", names)
          end

        end
      end
    end
  end
end
