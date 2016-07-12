require "metacrunch/hash" 
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddStatus < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "status", status) : status
  end

  private

  def status
    value = 'A'

    # gelöscht -> LDR Position 6 == 'd'
    value = 'D' if source.controlfield('LDR').at(5) == 'd'
    # ausgesondert über Feld 078
    value = 'D' if source.datafields('078', ind1: 'r').subfields('a').value.try(:downcase) == 'aus'
    # Standort Detmold unterdrücken
    detmold_locations = source.datafields('LOC').subfields('n').values.flatten
    value = 'D' if detmold_locations.present? && detmold_locations.all?{|v| v == '50'}
    # Interimsaufnahmen unterdrücken
    value = 'D' if source.datafields('537', ind1: '-', ind2: '1').subfields('a').values.flatten.any? { |v| v.downcase.include? 'interimsaufnahme' }

    # wenn gelöscht via datafield "DEL"
    value = 'D' if source.datafields('DEL').subfields('a').values.include?('Y')

    value
  end
end
