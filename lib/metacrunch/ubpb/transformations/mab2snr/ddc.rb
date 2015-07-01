module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class DDC < Metacrunch::Transformer::Step

          def perform
            target.add("control", "ddc", ddc)
          end

        private

          def ddc
            ddcs = []

            ddcs += source.datafields("700", ind1: "b").subfields("a").values
            ddcs += source.datafields("705", ind1: :blank).subfields("a").values

            ddcs.uniq
          end

        end
      end
    end
  end
end
