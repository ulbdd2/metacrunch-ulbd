require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddNotation < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "notation", notation) : notation
  end

  private

  def notation
    source.datafields('700', ind2: ' ').subfields('a').values
  end
end
