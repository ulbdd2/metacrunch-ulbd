require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddNotation < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "notation", notation) : notation
  end

  private

  def notation
    source.datafields('700', ind2: ' ').subfields('a').values
  end
end
