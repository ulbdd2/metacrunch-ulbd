module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class ResourceLink < Metacrunch::Transformer::Step

          def perform
            target.add("link", "resource", resource_links)
          end

        private

          #
          # TODO: Unterfelder u und z sind laut Doku wiederholbar.
          #   Kommt das in der Praxis vor und was soll das bedeuten?
          #
          def resource_links
            @resource_links ||= begin
              links = []

              source.datafields("655").each do |datafield|
                url   = datafield.subfields("u").first_value # URL
                label = datafield.subfields("y").first_value # Link Text

                # Ignore links that point to TOC
                if url && !helper.is_toc?(datafield)
                  links << { url: url, label: label }
                end
              end

              links
            end
          end

        end
      end
    end
  end
end
