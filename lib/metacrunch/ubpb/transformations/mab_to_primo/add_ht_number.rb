require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddHtNumber < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "ht_number", ht_number) : ht_number
  end

  private

  def ht_number
    source.datafields('001', ind2: '1').subfields('a').value
  end
end
