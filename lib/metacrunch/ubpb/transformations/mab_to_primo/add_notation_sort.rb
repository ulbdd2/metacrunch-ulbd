require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./add_notation"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddNotationSort < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "notation_sort", notation_sort) : notation_sort
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
