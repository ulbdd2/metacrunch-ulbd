module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        module Helpers
          module CommonHelper

            def is_superorder?
              @is_superorder ||= begin
                f051 = source.controlfield("051") || []
                f052 = source.controlfield("052") || []

                f051.at(0) == "n" ||
                f051.at(0) == "t" ||
                f052.at(0) == "p" ||
                f052.at(0) == "r" ||
                f052.at(0) == "z"
              end
            end

            def is_journal?
              @is_journal ||= begin
                f052 = source.controlfield("052") || []
                f052.at(0) == "p"
              end
            end

            def is_toc?(datafield_655)
              u3  = datafield_655.subfields("3").first_value # Hinweise auf HBZ Inhaltsverzeichnisse
              uz  = datafield_655.subfields("z").first_value # Hinweise auf BVB Inhaltsverzeichnisse
              ut  = datafield_655.subfields("t").first_value # Type: VIEW => Adam Inhaltsverzeichnis

              !!(u3 =~ /^inhaltsv/i || uz =~ /^inhaltsv/i || ut =~ /^view/i)
            end

          end
        end
      end
    end
  end
end
