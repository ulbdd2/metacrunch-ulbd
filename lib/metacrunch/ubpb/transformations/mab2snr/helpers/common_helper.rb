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

          end
        end
      end
    end
  end
end
