module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class VolumeCount < Metacrunch::Transformer::Step

          def perform
            target.add("control", "volume_count", volume_count)
          end

        private

          def volume_count
            volumes = []

            (456..496).step(10) do |f|
              volumes += source.datafields("#{f}", ind2: "1").subfields("a").values
            end

            volumes.find{ |v| v.present? }.to_i
          end

        end
      end
    end
  end
end
