module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class CreationDate < Metacrunch::Transformer::Step

          def perform
            values = source.datafields("LOC").subfields("k").values
            date   = values.find{ |v| v.present? }

            target.add("control", "creation_date", date)
          end

        end
      end
    end
  end
end
