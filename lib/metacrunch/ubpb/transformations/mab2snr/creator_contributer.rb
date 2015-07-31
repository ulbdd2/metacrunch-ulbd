module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class CreatorContributor < Metacrunch::Transformer::Step

          def perform
            target.add("display", "creator", creators)
            target.add("display", "contributor", contributors)
          end

        private

          def creators
            @creators ||= begin
              creators = []

              # Personen
              (100..196).step(4) do |f|
                datafield = source.datafields("#{f}", ind1: :blank).first
                creators << build_person(datafield) if datafield
              end

              # Körperschaften
              (200..296).step(4) do |f|
                datafield = source.datafields("#{f}", ind1: :blank).first
                creators << build_corporate_body(datafield) if datafield
              end

              creators
            end
          end

          def contributors
            @contributors ||= begin
              contributors = []

              # Personen
              (100..196).step(4) do |f|
                source.datafields("#{f}").each do |datafield|
                  if ["b", "c", "e", "f"].include?(datafield.ind1)
                    contributors << build_person(datafield)
                  end
                end
              end

              # Körperschaften
              (200..296).step(4) do |f|
                source.datafields("#{f}").each do |datafield|
                  if ["b", "c", "e"].include?(datafield.ind1)
                    contributors << build_corporate_body(datafield)
                  end
                end
              end

              contributors
            end
          end

          def build_person(datafield)
            {
              type: "person",
              name: datafield.subfields("a").first_value || datafield.subfields("p").first_value,
              add_name: datafield.subfields("c").first_value,
              count: datafield.subfields("n").first_value,
              date: datafield.subfields("d").first_value,
              role: extract_role(datafield.subfields("b").first_value),
              gnd_id: datafield.subfields("9").first_value
            }
          end

          def build_corporate_body(datafield)
            {
              type: "corporate_body",
              name: datafield.subfields("a").first_value ||
                    datafield.subfields("k").first_value ||
                    datafield.subfields("e").first_value ||
                    datafield.subfields("g").first_value,
              add_data: datafield.subfields("h").first_value,
              count: datafield.subfields("n").first_value,
              date: datafield.subfields("d").first_value,
              place: datafield.subfields("c").first_value,
              gnd_id: datafield.subfields("9").first_value
            }
          end

          def extract_role(value)
            # TODO: Map role
            value[/\[(.+)\]/, 1] || value if value
          end

        end
      end
    end
  end
end
