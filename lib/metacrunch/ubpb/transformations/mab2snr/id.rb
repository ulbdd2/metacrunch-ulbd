module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR

        class Id < Metacrunch::Transformer::Step
          def perform
            target.add("control", "id", options[:source_id])
          end
        end

      end
    end
  end
end
