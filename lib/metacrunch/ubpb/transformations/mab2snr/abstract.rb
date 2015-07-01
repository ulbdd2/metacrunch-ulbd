module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Abstract < Metacrunch::Transformer::Step

          def perform
            target.add("display", "abstract", abstracts)
            target.add("search", "abstract", abstracts)
          end

        private

          def abstracts
            @abstracts ||= begin
              abstracts = []

              ["750", "753", "756"].each do |field|
                value = source.datafields(field).subfields("a").first_value
                abstracts << value unless value.blank?
              end

              abstracts
            end
          end

        end
      end
    end
  end
end
