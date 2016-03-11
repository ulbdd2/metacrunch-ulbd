require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCreatorContributorFacet < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "creator_contributor_facet", creator_contributor_facet) : creator_contributor_facet
  end

  private

  def creator_contributor_facet
    [
      source.get("Personen", include: "Überordnungen").map(&:normalized_name),
      source.get("Körperschaften", include: "Überordnungen").map(&:normalized_name)
    ]
    .flatten
    .compact
    .uniq
  end
end
