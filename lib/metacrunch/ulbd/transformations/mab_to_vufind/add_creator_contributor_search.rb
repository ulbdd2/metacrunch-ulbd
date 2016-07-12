require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreatorContributorSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "creator_contributor_search", creator_contributor_search) : creator_contributor_search
  end

  private

  def creator_contributor_search
    [
      source.get("Körperschaften").map(&:get),
      source.get("Körperschaften (Phrasenindex)").map(&:get),
      source.get("Personen").map(&:get),
      source.get("Personen (Phrasenindex)").map(&:get),
      source.get("Personen der Nebeneintragungen").map(&:get)
    ]
    .flatten
    .compact
    .uniq
  end
end
