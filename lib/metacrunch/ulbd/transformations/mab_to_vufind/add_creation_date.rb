require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreationDate < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "creation_date", creation_date) : creation_date
  end

  private

  def creation_date
    source.datafields('LOC', ind2: :blank).subfields('k').values.flatten.map(&:presence).compact.uniq
  end
end
