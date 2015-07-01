module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Toc < Metacrunch::Transformer::Step

          def perform
            target.add("search", "toc", toc) unless toc.blank?
          end

        private

          def toc
            @toc ||= begin
              source.datafields("TXT").map do |datafield|
                datafield.subfields("a").first_value
              end.join(" ")
            end
          end

        end
      end
    end
  end
end
