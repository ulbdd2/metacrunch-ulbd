module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        module Helpers
          module CommonHelper

            def is_superorder?
              unless @is_superorder
                f051 = source.controlfield("051") || []
                f052 = source.controlfield("052") || []

                @is_superorder = (
                  f051.at(0) == "n" ||
                  f051.at(0) == "t" ||
                  f052.at(0) == "p" ||
                  f052.at(0) == "r" ||
                  f052.at(0) == "z"
                )
              end

              @is_superorder
            end

          end
        end
      end
    end
  end
end
