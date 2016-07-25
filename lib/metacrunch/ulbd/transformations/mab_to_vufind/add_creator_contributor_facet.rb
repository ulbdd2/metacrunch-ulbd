require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreatorContributorFacet < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "author_facet_str_mv", creator_contributor_facet) : creator_contributor_facet
  end

  private

  def creator_contributor_facet
    [
      source.get("Personen2", include: "Überordnungen").map(&:get),
      source.get("Körperschaften2", include: "Überordnungen").map(&:get)
    ]
    .flatten
    .compact
    .uniq
  end
end
