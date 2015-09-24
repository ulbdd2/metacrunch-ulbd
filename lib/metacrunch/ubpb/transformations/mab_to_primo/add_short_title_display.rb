require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/datafield_089"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddShortTitleDisplay < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::Datafield089

  def call
    target ? Metacrunch::Hash.add(target, "short_title_display", short_title_display) : short_title_display
  end

  private

  def short_title_display
    bandangabe_in_vorlageform                     = datafield_089.value
    hauptsachtitel_in_ansetzungsform              = source.datafields('310', ind1: ['-', 'a'], ind2: '1').subfields('a').value
    hauptsachtitel_in_vorlageform                 = source.datafields('331', ind2: '1').subfields('a').value
    hauptsachtitel_der_überordnung_in_vorlageform = source.datafields('331', ind2: '2').subfields('a').value
    allgemeine_materialbenennung                  = source.datafields('334', ind1: '-', ind2: '1').value
    zusätze_zum_hauptsachtitel                    = source.datafields('335', ind2: '1').subfields('a').value

    # helper
    bandangabe_may_be_used_as_title = -> (bandangabe) {
      if bandangabe
        has_minimal_length = bandangabe_in_vorlageform.length > 3
        does_not_only_contain_numbers_or_spaces = bandangabe_in_vorlageform[/\A(\d|\s)+\Z/].nil?
        is_no_well_known_identifier = !['buch', 'hauptbd.'].include?(bandangabe_in_vorlageform.gsub(/\[|\]/, '').downcase)

        has_minimal_length && does_not_only_contain_numbers_or_spaces && is_no_well_known_identifier
      end
    }

    if hauptsachtitel_in_ansetzungsform
      hauptsachtitel_in_ansetzungsform
    elsif hauptsachtitel_in_vorlageform
      [
        "#{hauptsachtitel_in_vorlageform}",
        if allgemeine_materialbenennung then "[#{allgemeine_materialbenennung}]" end,
        if zusätze_zum_hauptsachtitel   then ": #{zusätze_zum_hauptsachtitel}"   end
      ]
      .compact.join(" ")
    elsif bandangabe_may_be_used_as_title.call(bandangabe_in_vorlageform)
      bandangabe_in_vorlageform.gsub(/.*(bd|Bd).*\,/, '') # Try to remove volume count from
    elsif hauptsachtitel_der_überordnung_in_vorlageform
      hauptsachtitel_der_überordnung_in_vorlageform
    end
    .try do |_title|
      _title.gsub(/<<|>>/, '').strip.presence
    end
    .try do |_cleaned_title|
      _cleaned_title[0].upcase << _cleaned_title[1..-1]
    end
  end
end
