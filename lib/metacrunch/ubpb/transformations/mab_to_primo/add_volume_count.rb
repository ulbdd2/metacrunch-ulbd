require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddVolumeCount < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "volume_count", volume_count) : volume_count
  end

  private

  def volume_count
    # Bandzählung von Reihen
    volumes = []
    (456..496).step(10) do |f|
      value = source.datafields("#{f}", ind2: '1').subfields('a').value
      volumes << value if value.present?
    end
    volumes.first
  end
end
