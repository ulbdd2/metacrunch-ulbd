module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class ResourceLink < Metacrunch::Transformer::Step

          def perform
            target.add("display", "link", resource_links)
          end

        private

          #
          # TODO: Unterfelder u und z sind laut Doku wiederholbar.
          #   Kommt das in der Praxis vor und was soll das bedeuten?
          #
          def resource_links
            links = []

            source.datafields("655").each do |datafield|
              url = datafield.subfields("u").first_value # URL
              u3  = datafield.subfields("3").first_value # Hinweise auf HBZ Inhaltsverzeichnisse
              uz  = datafield.subfields("z").first_value # Hinweise auf BVB Inhaltsverzeichnisse
              ut  = datafield.subfields("t").first_value # Type: VIEW => Adam Inhaltsverzeichnis

              # Ignore links that point to known tocs
              links << url unless url && (u3 =~ /^inhaltsv/i || uz =~ /^inhaltsv/i || ut =~ /^view/i)
            end

            binding.pry unless links.empty?

            links
          end

        end
      end
    end
  end
end
