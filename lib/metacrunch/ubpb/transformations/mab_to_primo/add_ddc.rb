require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddDDC < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "ddc", ddc) : ddc
  end

  private

  def ddc
    ddc_fields = []
    ddc_fields << source.datafields('700', ind1: 'b', ind2: '1').subfields('a').values
    ddc_fields << source.datafields('705', ind1: :blank, ind2: '1').subfields('a').values

    ddc_fields.flatten.map(&:presence).compact.uniq
  end
end
