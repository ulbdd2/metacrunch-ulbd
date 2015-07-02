module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class VolumeCount < Metacrunch::Transformer::Step

          def perform
            target.add("display", "volume_count", display)
            target.add("sort", "volume_count", sort)
          end

        private

          #
          # Bandangaben in Vorlageform
          #
          def display
            counts = []

            counts << source.datafields("089").subfields("a").first_value
            (455..495).step(10) do |f|
              counts << source.datafields("#{f}", ind2: "1").subfields("a").first_value
            end

            # Take the first that holds a value
            counts.find{ |v| v.present? }
          end

          #
          # Bandangaben in Sortierform
          #
          # Die Werte können in der einfachsten Form Zahlen sein.
          # Es kann aber auch vorkommen, dass Gruppen gebildet werden. Diese
          # werden durch ein Komma getrennt. Zusätzlich ist eine
          # lexikografische Sortierform denkbar.
          #
          # Beispiele: "10", "42", "5,4", "5,4,2", "m", "m,mex"
          #
          def sort
            counts = []

            counts << source.datafields("090", ind2: "1").subfields("a").first_value
            (456..496).step(10) do |f|
              counts << source.datafields("#{f}", ind2: "1").subfields("a").first_value
            end

            # Take the first that holds a value
            count = counts.find{ |v| v.present? }

            # Make sortable "value"
            build_sortable_string(count) unless count.blank?
          end

          def build_sortable_string(count)
            # extract the count groups
            count_groups = count.split(',')
            # make sure we have always 4 groups
            count_groups = Array.new(4) { |i| count_groups[i] }
            # make sure every group is a string
            count_groups.map!{ |g| g.to_s }
            # clean things up a bit
            count_groups.map!{ |g| g.gsub(/\[|\]/, '').strip }
            # fill up each group to 6 characters
            count_groups.map!{ |g| g.rjust(6, '0') }
            # make sure each group is really 6 characters.
            count_groups.map!{ |g| g[0..5] }
            # finally join
            count_groups.join
          end

        end
      end
    end
  end
end
