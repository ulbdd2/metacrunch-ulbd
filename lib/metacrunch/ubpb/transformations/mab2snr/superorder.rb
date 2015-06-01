module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Superorder < Metacrunch::Transformer::Step

          def perform
            target.add("control", "superorder", helper.is_superorder?)
          end

        end
      end
    end
  end
end
