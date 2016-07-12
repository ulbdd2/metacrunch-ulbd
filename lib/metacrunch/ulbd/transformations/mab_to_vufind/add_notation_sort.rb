require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_notation"

class Metacrunch::ULBD::Transformations::MabToVufind::AddNotationSort < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "notation_sort", notation_sort) : notation_sort
  end

  private

  def notation_sort
    [notation].flatten(1).compact.last
  end

  private

  def notation
    target.try(:[], "notation") || self.class.parent::AddNotation.new(source: source).call
  end
end
