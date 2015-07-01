module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class TypeOfContent< Metacrunch::Transformer::Step

          def perform
            target.add("control", "type_of_content", type_of_content)
          end

        private

          def type_of_content
            f051 = source.controlfield("051").values
            f051 = Array.new(14) if f051.empty?

            f052 = source.controlfield("052").values
            f052 = Array.new(14) if f052.empty?

            f051_13 = f051.slice(1..3).join
            f052_16 = f052.slice(1..6).join

            case
              # Monos
              when f051_13.include?("b") then "bibliography"
              when f051_13.include?("c") then "catalog"
              when f051_13.include?("d") then "dictionary"
              when f051_13.include?("e") then "encyclopedia"
              when f051_13.include?("f") then "festschrift"
              when f051_13.include?("h") then "biography"
              when f051_13.include?("k") then "congress"
              when f051_13.include?("m") then "music"
              when f051_13.include?("n") then "norm"
              when f051_13.include?("u") then "university_text"
              when f051_13.include?("w") then "website"
              when f051_13.include?("x") then "textbook"
              when f051_13.include?("y") then "university_text"

              # Fortlaufende Sammelwerke (Zeitschriften u.ä.)
              when f052_16.include?("bi") then "bibliography"
              when f052_16.include?("ww") then "university_text"
              when f052_16.include?("fs") then "festschrift"
              when f052_16.include?("ko") then "congress"
              when f052_16.include?("wb") then "dictionary"
              when f052_16.include?("ez") then "encyclopedia"
              when f052_16.include?("bg") then "biography"
              when f052_16.include?("mu") then "music"
              when f052_16.include?("no") then "norm"
              when f052_16.include?("sc") then "textbook"
              when f052_16.include?("ws") then "website"
            else
              "other"
            end
          end

        end
      end
    end
  end
end
