module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class SelectionCode < Metacrunch::Transformer::Step

          def perform
            target.add("control", "selection_code", selection_code)
          end

        private

          def selection_code
            codes = []

            codes += source.datafields("078", ind1: "e").subfields("a").values
            codes += source.datafields("078", ind1: "r").subfields("a").values

            codes
          end

        end
      end
    end
  end
end
