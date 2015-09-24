require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCreationDate < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "creation_date", creation_date) : creation_date
  end

  private

  def creation_date
    source.datafields('LOC', ind2: :blank).subfields('k').values.flatten.map(&:presence).compact.uniq
  end
end
