module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Toc < Metacrunch::Transformer::Step

          def perform
            target.add("search",  "toc", toc)
            target.add("display", "toc", link_to_toc)
          end

        private

          def toc
            source.datafields("TXT").map do |datafield|
              datafield.subfields("a").first_value
            end.join(" ")
          end

          #
          # TODO: Unterfelder u und z sind laut Doku wiederholbar.
          #   Kommt das in der Praxis vor und was soll das bedeuten?
          #
          def link_to_toc
            links = []

            source.datafields("655").each do |datafield|
              url = datafield.subfields("u").first_value # URL
              u3  = datafield.subfields("3").first_value # Hinweise auf HBZ Inhaltsverzeichnisse
              uz  = datafield.subfields("z").first_value # Hinweise auf BVB Inhaltsverzeichnisse
              ut  = datafield.subfields("t").first_value # Type: VIEW => Adam Inhaltsverzeichnis

              links << url if url && (u3 =~ /^inhaltsv/i || uz =~ /^inhaltsv/i || ut =~ /^view/i)
            end

            links
          end

        end
      end
    end
  end
end
