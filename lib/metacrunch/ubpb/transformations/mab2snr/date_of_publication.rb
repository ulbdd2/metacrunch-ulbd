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
              @display_date = if dates["f595"].present?
                dates["f595"]
              elsif helper.is_superorder?
                superorder_date
              else
                default_date
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
              @dates["f425_a"] = source.datafields("425", ind1: "a", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr in Sortierform des frühsten Bandes
              @dates["f425_b"] = source.datafields("425", ind1: "b", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr in Sortierform des letzten Bandes
              @dates["f425_c"] = source.datafields("425", ind1: "c", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr in Sortierform eines Tonträgers
              @dates["f425_p"] = source.datafields("425", ind1: "p", ind2: "1").subfields("a").first_value
              # Erscheinungsjahr der Quelle
              @dates["f595"]    = source.datafields("595").subfields("a").first_value # TODO: SUBFIELD A?
            end

            @dates
          end

          def default_date
            dates["f425_a"].presence || dates["f425_p"].presence
          end

          def superorder_date
            if dates["f425_b"].present? and dates["f425_c"].present?
              if dates["f425_b"] == dates["f425_c"]
                dates["f425_b"]
              else
                "#{dates['f425_b']} – #{dates['f425_c']}"
              end
            elsif dates["f425_b"].present? and not dates["f425_c"].present?
              "#{dates['f425_b1']} –"
            elsif dates["f425_c"].present? and not dates["f425_b"].present?
              "– #{dates['f425_c']}"
            else
              default_date
            end
          end

        end
      end
    end
  end
end
