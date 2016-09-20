require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreatorContributorSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "creator_contributor_search_txt_mv", creator_contributor_search) : creator_contributor_search
  end

  private

  def creator_contributor_search
    [
      source.get("Körperschaften2", include: "Überordnungen").map(&:get),
      source.get("Körperschaften Os", include: "Überordnungen").map(&:get),
      source.get("Körperschaften (Phrasenindex)", include: "Überordnungen").map(&:get),
      source.get("Personen2", include: "Überordnungen").map(&:get),
      source.get("Personen Os", include: "Überordnungen").map(&:get),
      source.get("Personen (Phrasenindex)", include: "Überordnungen").map(&:get),
      source.get("Personen der Nebeneintragungen", include: "Überordnungen").map(&:get),
      source.get("Körperschaften der Nebeneintragungen", include: "Überordnungen").map(&:get),
      source.get("Verantwortlichkeitsangaben", include: "Überordnungen").map(&:get),
      source.get("Verantwortlichkeitsangaben2", include: "Überordnungen").map(&:get)
    ]
    .flatten
    .compact
    .uniq
  end
end
