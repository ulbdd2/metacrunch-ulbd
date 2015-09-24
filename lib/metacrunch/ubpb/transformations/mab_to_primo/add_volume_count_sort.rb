require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddVolumeCountSort < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "volume_count_sort", volume_count_sort) : volume_count_sort
  end

  private

  def volume_count_sort
    possible_values = []
    possible_values << source.datafields('090', ind2: '1').subfields('a').value
    (451..491).step(10) { |f| possible_values << source.datafields("#{f+5}", ind2: '1').subfields('a').value }
    count = possible_values.map(&:presence).compact.uniq.first
    count.rjust(15, '0') if count.present?
  end
end
