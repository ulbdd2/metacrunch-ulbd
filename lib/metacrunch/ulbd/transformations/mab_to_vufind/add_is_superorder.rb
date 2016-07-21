require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./helpers/is_superorder"

class Metacrunch::ULBD::Transformations::MabToVufind::AddIsSuperorder < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::IsSuperorder

  def call
    target ? Metacrunch::Hash.add(target, "is_superorder_str", is_superorder?) : is_superorder?
  end
end
