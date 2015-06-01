module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Title < Metacrunch::Transformer::Step

          def perform
            target.add("search",  "title", title_search)
            target.add("display", "title", title_display)
            target.add("sort",    "title", title_sort)
          end

        private

          def title_search
            title_parts.values.map do |t|
              v = [*t].join(" ").presence

              if v
                v.delete!("<<")
                v.delete!(">>")
              end

              v
            end.compact
          end

          def title_display
            title = title_display_and_sort
            title.delete!("<<")
            title.delete!(">>")
            title
          end

          def title_sort
            title = title_display_and_sort
            title.gsub!(/<<.*>>\s/, "")
            title
          end

          #
          # TODO: Review the old implementation for 089
          #   elsif f089_1 && f089_1.length > 3 && f089_1[/\A(\d|\s)+\Z/].nil? && !['buch', 'hauptbd.'].include?(f089_1.gsub(/\[|\]/, '').downcase)
          #   f089_1.gsub(/.*(bd|Bd).*\,/, '') # Try to remove volume count from
          #
          def title_display_and_sort
            p = title_parts

            if p["310_1"]
              p["310_1"]
            elsif p["331_1"] && p["334_1"] && p["335_1"]
              "#{p['331_1']} [#{p['334_1']}] : #{p['335_1']}"
            elsif p["331_1"] && p["335_1"]
              "#{p['331_1']} : #{p['335_1']}"
            elsif p["331_1"] && p["334_1"]
              "#{p['331_1']} [#{p['334_1']}]"
            elsif p["331_1"]
              p["331_1"]
            elsif p["331_2"]
              p["331_2"]
            elsif p["089_1"]
              p["089_1"]
            else
              "n.a."
            end
          end

          def title_parts
            unless @title_parts
              parts = {}

              parts["331_2"] = source.datafields("331", ind2: "2").subfields("a").first_value
              parts["333_2"] = source.datafields("333", ind2: "2").subfields("a").first_value
              parts["335_2"] = source.datafields("335", ind2: "2").subfields("a").first_value
              parts["360_2"] = source.datafields("360", ind2: "2").subfields("a").values

              parts["089_1"] = source.datafields("089", ind2: "1").subfields('a').first_value
              parts["304_1"] = source.datafields("304", ind2: "1").subfields('a').first_value
              parts["310_1"] = source.datafields("310", ind2: "1").subfields('a').first_value
              parts["331_1"] = source.datafields("331", ind2: "1").subfields('a').first_value
              parts["333_1"] = source.datafields("333", ind2: "1").subfields('a').first_value
              parts["335_1"] = source.datafields("335", ind2: "1").subfields('a').first_value
              parts["340_1"] = source.datafields("340", ind2: "1").subfields('a').first_value
              parts["341_1"] = source.datafields("341", ind2: "1").subfields('a').first_value
              parts["360_1"] = source.datafields("360", ind2: "1").subfields('a').values

              (342..355).each do |f|
                parts["#{f}_1"] = source.datafields("#{f}", ind2: "1").subfields('a').first_value
              end

              parts["370_1"] = source.datafields("370", ind2: "1").subfields('a').values
              parts["376_1"] = source.datafields("376", ind2: "1").subfields('a').values

              (451..491).step(10).each do |f|
                parts["#{f}_1"] = source.datafields("#{f}", ind2: "1").subfields('a').first_value
              end

              parts["502_1"] = source.datafields("502", ind2: "1").subfields('a').first_value
              parts["504_1"] = source.datafields("504", ind2: "1").subfields('a').first_value
              parts["505_1"] = source.datafields("505", ind2: "1").subfields('a').first_value

              (526..534).each do |f|
                parts["#{f}_1"] = source.datafields("#{f}", ind2: "1").subfields('a').first_value
              end

              parts["621_1"] = source.datafields("621", ind2: "1").subfields('a').first_value
              parts["627_1"] = source.datafields("627", ind2: "1").subfields('a').first_value
              parts["633_1"] = source.datafields("633", ind2: "1").subfields('a').first_value

              @title_parts = parts
            end

            @title_parts
          end

        end
      end
    end
  end
end
