module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class ZDBId < Metacrunch::Transformer::Step

          def perform
            target.add("control", "zdb_id", zdb_id) unless zdb_id.blank?
          end

        private

          def zdb_id
            @zdb_id ||= begin
              source.datafields("025", ind1: "z").subfields("a").first_value
            end
          end

        end
      end
    end
  end
end