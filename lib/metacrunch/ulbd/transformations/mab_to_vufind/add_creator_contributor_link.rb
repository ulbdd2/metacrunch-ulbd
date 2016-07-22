require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "../../../ulbd/record"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreatorContributorLink < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "author_link_str", creator_contributor_link) : creator_contributor_link
  end

  private

  def creator_contributor_link
    creators = []

    creators << source.get("Personen", include: "Überordnungen").map(&:get)
    

    creators << source.get("Körperschaften", include: "Überordnungen").map(&:get)
  

    # Sonderfall: Verfasserangaben enthält [u.a.]
    if source.get("Verantwortlichkeitsangaben").any? { |v| v.get.try(:[], /\.\.\.|\[u\.a\.\]/i) }
      creators << "[u.a.]"
    end

    # Cleanup
    creators.flatten.map(&:presence).compact.uniq.join("; ")
  end
  
end
