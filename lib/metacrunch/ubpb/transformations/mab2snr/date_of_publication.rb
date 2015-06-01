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

        private

          def display_date
            unless @display_date
              d = dates

              @display_date = if d["f595"].present?
                d["f595"]
              elsif helper.is_superorder?
                if d["f425_b1"].present? and d["f425_c1"].present?
                  if d["f425_b1"] == d["f425_c1"]
                    d["f425_b1"]
                  else
                    "#{d['f425_b1']} – #{d['f425_c1']}"
                  end
                elsif d["f425_b1"].present? and not d["f425_c1"].present?
                  "#{d['f425_b1']} –"
                elsif d["f425_c1"].present? and not d["f425_b1"].present?
                  "– #{d['f425_c1']}"
                else
                  d["f425_a1"].presence || d["f425_p1"].presence
                end
              else
                d["f425_a1"].presence || d["f425_p1"].presence
              end
            end

            @display_date
          end

          def search_date
            unless @search_date
              if display_date
                date = display_date.dup
                date.gsub!(/[^0-9]/i, "") # Entferne alle nicht numerischen Zeichen
                @search_date = date
              end
            end

            @search_date
          end

          def dates
            unless @dates
              @dates = {}

              # Erscheinungsjahr in Sortierform
              @dates["f425_a1"] = source.datafields("425", ind1: "a", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr in Sortierform des frühsten Bandes
              @dates["f425_b1"] = source.datafields("425", ind1: "b", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr in Sortierform des letzten Bandes
              @dates["f425_c1"] = source.datafields("425", ind1: "c", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr in Sortierform eines Tonträgers
              @dates["f425_p1"] = source.datafields("425", ind1: "p", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr der Quelle
              @dates["f595"]    = source.datafields("595").subfields("a").first_value # TODO: SUBFIELD A?
            end

            @dates
          end

        end
      end
    end
  end
end
