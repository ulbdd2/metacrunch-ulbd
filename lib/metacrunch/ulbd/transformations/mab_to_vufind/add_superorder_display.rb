require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./helpers/datafield_089"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSuperorderDisplay < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::Datafield089

  def call
    target ? Metacrunch::Hash.add(target, "superorder_display_str_mv", superorder_display) : superorder_display
  end

  private

  def superorder_display
    superorders = []

    # Link zur Überordung eines mehrbändigen Werkes
    superorders << {
      ht_number: source.datafields('010', ind2: '1').subfields('a').value,
      label: source.datafields('331', ind2: '2').subfields('a').value,
      volume_count: datafield_089.value # Bandzählung dieses Werkes innerhalb der entsprechenden Überordnung
    }

    # 451 ff
    (451..491).step(10) do |f|
      superorders << {
        ht_number: source.datafields("#{f+2}", ind2: '1').subfields('a').value,
        label: [
          source.datafields("#{f}", ind2: '1').subfields('a').value,
          source.datafields("#{f}", ind2: '2').subfields('a').value
        ]
        .compact
        .reject { |label|
          label[/\A\.\.\.\s+(;|:)/] 
        }
        .first,
        volume_count: [
          source.datafields("#{f+4}", ind2: '1').subfields('a').value,
          source.datafields("#{f}", ind2: '1').subfields('v').value # RDA
        ]
        .compact
        .first
        .try(:gsub, /\A(\d{1,3})\Z/, "Bd. \\1")
      }
    end

    superorders
    .map(&:presence)
    .delete_if { |element| element[:label].blank? }
    .deep_dup # to be able tu use .gsub!
    .each do |element|
      # remove 'not sort' indicators from label
      element[:label].try(:gsub!, /<<|>>/, '')

      # remove leading '... ' from label
      element[:label].try(:gsub!, /\A\.\.\.\s+/, '')

      # get label additions (everything behind the first ':') and make it a clean array
      element[:label_additions] = if element[:label].present?
        element[:label][/:.*/]
        .try(:gsub, /(\A:)|(,\Z)/, '')
        .try(:strip)
        .try(:gsub, /,/, ';')
        .try(:split, ';')
        .try(:map, &:strip)
      end

      # remove every label addition that is also in volume count (space removement and downcasing are done for more fuzzy matching e.g. between 'Faz. 4' and 'faz.4'
      if element[:label_additions].present? && element[:volume_count].present?
        volume_count_elements = element[:volume_count].downcase.gsub(/,|:|;/, ';').gsub(/bd\.\s*/, "").split(';').map { |e| e.gsub(/\s+/, '') } # volume_count elements without spaces for more fuzzy comparing

        element[:label_additions].reject! { |label_addition| volume_count_elements.include? label_addition.gsub(/\s+/, '').downcase }
        element[:label_additions].reject! { |label_addition| ['bd', 'band'].any? { |forbidden_label_addition| label_addition.downcase.starts_with? forbidden_label_addition } } # additional remove every Bd. or Band
        element[:label_additions] = element[:label_additions].presence
      end

      # remove any label additions from the label
      element[:label].try(:gsub!, /:.*\Z/, '')
      element[:label].try(:gsub!, /;.*\Z/, '')
      element[:label].try(:strip!)

      element[:volume_count].try(:gsub!, /<.*>/, '')
    end.uniq.map(&:to_json)
  end
end
