module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Superorder < Metacrunch::Transformer::Step

          def perform
            target.add("display", "superorder", superorder_display)
          end

        private

          def superorder_display
            superorders = []

            # Link zur Überordung eines mehrbändigen Werkes
            superorders << {
              "ht_number" => source.datafields('010', ind2: '1').subfields('a').first_value,
              "label" => source.datafields('331', ind2: '2').subfields('a').first_value,
              "volume_count" => source.datafields('089', ind2: '1').subfields('a').first_value # Bandzählung dieses Werkes innerhalb der entsprechenden Überordnung
            }

            # 451 ff
            (451..491).step(10) do |f|
              superorders << {
                "ht_number" => source.datafields("#{f+2}", ind2: '1').subfields('a').first_value,
                "label" => [source.datafields("#{f}", ind2: '1').subfields('a').first_value, source.datafields("#{f}", ind2: '2').subfields('a').first_value].compact.reject { |label| label[/\A\.\.\.\s+(;|:)/] }.first,
                "volume_count" => source.datafields("#{f+4}", ind2: '1').subfields('a').first_value
              }
            end

            superorders
            .map(&:presence)
            .delete_if { |element| element["label"].blank? }
            .each do |element|
              # remove 'not sort' indicators from label
              element["label"].try(:gsub!, /<<|>>/, '')

              # remove leading '... ' from label
              element["label"].try(:gsub!, /\A\.\.\.\s+/, '')

              # get label additions (everything behind the first ':') and make it a clean array
              element["label_additions"] = if element["label"].present?
                element["label"][/:.*/]
                .try(:gsub, /(\A:)|(,\Z)/, '')
                .try(:strip)
                .try(:gsub, /,/, ';')
                .try(:split, ';')
                .try(:map, &:strip)
              end

              # remove every label addition that is also in volume count (space removement and downcasing are done for more fuzzy matching e.g. between 'Faz. 4' and 'faz.4'
              if element["label_additions"].present? && element["volume_count"].present?
                volume_count_elements = element["volume_count"].gsub(/,|:|;/, ';').split(';').map { |e| e.gsub(/\s+/, '').downcase } # volume_count elements without spaces for more fuzzy comparing

                element["label_additions"].reject! { |label_addition| volume_count_elements.include? label_addition.gsub(/\s+/, '').downcase }
                element["label_additions"].reject! { |label_addition| ['bd', 'band'].any? { |forbidden_label_addition| label_addition.downcase.starts_with? forbidden_label_addition } } # additional remove every Bd. or Band
                element["label_additions"] = element["label_additions"].presence
              end

              # remove any label additions from the label
              element["label"].try(:gsub!, /:.*\Z/, '')
              element["label"].try(:gsub!, /;.*\Z/, '')
              element["label"].try(:strip!)

              element["volume_count"].try(:gsub!, /<.*>/, '')
            end
            .uniq
            .map do |_mabmapper_superorder|
              {
                "identifier" => { "hbz_id" => _mabmapper_superorder["ht_number"] }.compact.presence,
                "title" => [_mabmapper_superorder["label"], _mabmapper_superorder["label_additions"]].compact.join(" : "),
                "volume" => _mabmapper_superorder["volume_count"]
              }.compact
            end
          end
        end
      end
    end
  end
end
