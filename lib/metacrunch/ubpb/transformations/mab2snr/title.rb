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
            if title_display_and_sort
              title = title_display_and_sort.dup
              title.delete!("<<")
              title.delete!(">>")
              title
            end
          end

          def title_sort
            if title_display_and_sort
              title = title_display_and_sort.dup
              title.gsub!(/<<.*>>\s/, "")
              title
            end
          end

          #
          # TODO: Review the old implementation for 089
          #   elsif f089_1 && f089_1.length > 3 && f089_1[/\A(\d|\s)+\Z/].nil? && !['buch', 'hauptbd.'].include?(f089_1.gsub(/\[|\]/, '').downcase)
          #   f089_1.gsub(/.*(bd|Bd).*\,/, '') # Try to remove volume count from
          #
          def title_display_and_sort
            @title_display_and_sort ||= begin
              p    = title_parts
              ind2 = helper.is_superorder? ? "2" : "1"

              title = if p["360_#{ind2}"].present?
                p["310_#{ind2}"].first
              elsif p["331_1"].present?
                p["331_1"].first
              elsif p["331_2"].present?
                p["331_2"].first
              elsif p["089_1"].present?
                p["089_1"].first
              else
                ""
              end

              if p["334_1"].present?
                title += " [#{p['334_1'].first}]"
              elsif p["334_2"].present?
                title += " [#{p['334_2'].first}]"
              end

              if p["331_1"].present? && p["335_1"].present?
                title += " : #{p['335_1'].first}"
              end

              if p["331_1"].present? && p["361_1"].present?
                title += ". #{p['361_1'].first}"
              end

              title
            end
          end

          def title_parts
            @title_parts ||= begin
              parts = {}

              fields.each do |field|
                field_s = sprintf "%03d", field

                parts["#{field_s}_1"] = values_for(field_s, 1)
                parts["#{field_s}_2"] = values_for(field_s, 2)
              end

              parts
            end
          end

          def values_for(field, ind2)
            source.datafields("#{field}", ind2: "#{ind2}").subfields("a").values
          end

          def fields
            fields = 89, 304, 310, 331, 333, 334, 335, *(340..355), 360, 361,
              365, 370, 376, *(451..491).step(10).to_a, 502, 504, 505, 517,
              *(526..534), 590, 592, 597, 621, 624, 627, 630, 633
          end

        end
      end
    end
  end
end
