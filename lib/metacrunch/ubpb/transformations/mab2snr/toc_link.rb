module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class TocLink < Metacrunch::Transformer::Step

          def perform
            target.add("link", "toc", link_to_toc)
          end

        private

          def link_to_toc
            links = []

            source.datafields("655").each do |datafield|
              url = datafield.subfields("u").first_value

              # Pick only links that point to known tocs
              if url && helper.is_toc?(datafield)
                links << url
              end
            end

            links
          end

        end
      end
    end
  end
end
