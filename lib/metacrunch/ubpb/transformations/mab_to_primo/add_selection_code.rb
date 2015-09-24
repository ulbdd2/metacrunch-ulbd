require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddSelectionCode < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "selection_code", selection_code) : selection_code
  end

  private

  def selection_code
    codes = []
    codes << source.datafields('078', ind1: ['e', 'r']).subfields('a').values

    codes.flatten.map(&:presence).compact.uniq
  end
end
