require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/is_superorder"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddIsSuperorder < Transformator::Transformation::Step
  include parent::Helpers::IsSuperorder

  def call
    target ? MightyHash.add(target, "is_superorder", is_superorder?) : is_superorder?
  end
end
