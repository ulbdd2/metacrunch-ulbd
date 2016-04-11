require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddLinks < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "links", links) : links
  end

  private

  def links
    binding.pry
    source.get("elektronische Adressen")
  end
end
