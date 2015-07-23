module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class IsSuperorder < Metacrunch::Transformer::Step

          def perform
            target.add("control", "is_superorder", helper.is_superorder?)
          end

        end
      end
    end
  end
end
