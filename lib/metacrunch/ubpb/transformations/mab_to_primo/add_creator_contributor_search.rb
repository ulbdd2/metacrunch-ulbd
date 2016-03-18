require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCreatorContributorSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "creator_contributor_search", creator_contributor_search) : creator_contributor_search
  end

  private

  def creator_contributor_search
    [
      source.get("Körperschaften").map(&:normalized_name),
      source.get("Körperschaften Phrasenindex").map(&:normalized_name),
      source.get("Personen").map(&:normalized_name),
      source.get("Personen Phrasenindex").map(&:normalized_name),
      source.get("Personen der Nebeneintragungen").map(&:normalized_name)
    ]
    .flatten
    .compact
    .uniq
  end
end
