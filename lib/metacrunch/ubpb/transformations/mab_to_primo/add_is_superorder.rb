require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/is_superorder"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddIsSuperorder < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::IsSuperorder

  def call
    target ? Metacrunch::Hash.add(target, "is_superorder", is_superorder?) : is_superorder?
  end
end
