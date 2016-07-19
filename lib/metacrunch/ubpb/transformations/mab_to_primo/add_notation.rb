require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddNotation < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "notation", notation) : notation
  end

  private

  def notation
    source.datafields('700', ind1: 'h', ind2: ['1', '2']).subfields('a').values.uniq
  end
end
