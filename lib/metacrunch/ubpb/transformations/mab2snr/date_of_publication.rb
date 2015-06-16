module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class DateOfPublication < Metacrunch::Transformer::Step

          def perform
            target.add("display", "date_of_publication", display_date)
            target.add("search",  "date_of_publication", search_date)
            target.add("sort",    "date_of_publication", search_date)
          end

          def display_date
            unless @display_date
              @display_date = if dates["595"].present?
                dates["595"]
              elsif helper.is_superorder?
                range = superorder_date_range
                [range[0], range[1]].join(" – ").strip
              else
                default_date
              end
            end

            @display_date
          end

          def search_date
            unless @search_date
              @search_date = if dates["595"].present?
                dates["595"]
              elsif helper.is_superorder?
                superorder_date_range.find{|v| v.present?}
              else
                default_date
              end
            end

            @search_date
          end

          def dates
            unless @dates
              @dates = {}

              # Erscheinungsjahr in Ansetzungsform
              @dates["425a"] = source.datafields("425", ind1: "a", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr in Ansetzungsform des frühsten Bandes
              @dates["425b"] = source.datafields("425", ind1: "b", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr in Ansetzungsform des letzten Bandes
              @dates["425c"] = source.datafields("425", ind1: "c", ind2: "1").subfields("a").first_value
              # Publikationsdatum eines Tonträgers
              @dates["425p"] = source.datafields("425", ind1: "p", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr der Quelle
              @dates["595"]   = source.datafields("595").subfields("a").first_value # TODO: SUBFIELD A?
            end

            @dates
          end

          def default_date
            dates["425a"].presence || dates["425p"].presence
          end

          def superorder_date_range
            if dates["425b"].blank? and dates["425c"].blank?
              [default_date]
            else
              [dates["425b"], dates["425c"]].uniq
            end
          end

        end
      end
    end
  end
end
