require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddNotation < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "notation", notation) : notation
  end

  private

  def notation
    source.datafields('700', ind1: 'h', ind2: ['1', '2']).subfields('a').values.uniq
  end
end
