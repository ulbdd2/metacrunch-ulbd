require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddHtNumber < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "ht_number", ht_number) : ht_number
  end

  private

  def ht_number
    source.datafields('001', ind2: '1').subfields('a').value
  end
end
