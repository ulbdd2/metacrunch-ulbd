require "metacrunch/hash" 
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddStatus < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "status", status) : status
  end

  private

  def status
    value = 'A'

    # gelöscht -> LDR Position 6 == 'd'
    value = 'D' if source.controlfield('LDR').at(5) == 'd'
    # Exemplarstatus unterdruecken
    value = 'D' if source.datafields('LOC').subfields('n').value == '50'
    value = 'D' if source.datafields('LOC').subfields('n').value == '51'
    value = 'D' if source.datafields('LOC').subfields('n').value == '55'
    titel_unterdruecken = source.datafields('LOC').subfields('n').values.flatten
    value = 'D' if titel_unterdruecken.present? && titel_unterdruecken.any?{|v| v == '90'}
    # Interimsaufnahmen unterdrücken
    value = 'D' if source.datafields('537', ind1: '-', ind2: '1').subfields('a').values.flatten.any? { |v| v.downcase.include? 'interimsaufnahme' }
    # Verbrauch und Storniert unterdrücken
    value = 'D' if source.datafields('ERW', ind1: '-', ind2: '1').subfields('a').values.flatten.any? { |v| v.downcase.include? 'verbrauch' }
    value = 'D' if source.datafields('STO', ind1: '-', ind2: '1').subfields('a').values.flatten.any? { |v| v.downcase.include? 'storniert' }
    # wenn gelöscht via datafield "DEL"
    value = 'D' if source.datafields('DEL').subfields('a').values.include?('Y')

    value
  end
end
