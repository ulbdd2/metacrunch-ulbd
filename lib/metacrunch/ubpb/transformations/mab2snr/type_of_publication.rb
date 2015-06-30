module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class TypeOfPublication < Metacrunch::Transformer::Step

          def perform
            target.add("control", "type_of_publication", type_of_publication)
          end

        private

          def type_of_publication
            f051 = source.controlfield("051").values
            f052 = source.controlfield("052").values

            f051_0  = f051[0]
            f051_13 = f051.slice(1..3).join

            f052_0  = f052[0]
            f052_16 = f052.slice(1..6).join

            case
              when f051_0 == "a" then "article"
              when f051_0 == "m" then "monograph"
              when f051_0 == "n" then "monograph"
              when f051_0 == "s" then "monograph"

              when f051_13.include?("t") then "article"

              when f052_0 == "a" then "article"
              when f052_0 == "p" then "journal"
              when f052_0 == "r" then "series"
              when f052_0 == "z" then "newspaper"

              when f052s.include?("au") then "article"
              when f052s.include?("se") then "series"
            else
              # TODO: helper.is_suborder? ? "monograph" : "other"
              "other"
            end
          end

        end
      end
    end
  end
end
