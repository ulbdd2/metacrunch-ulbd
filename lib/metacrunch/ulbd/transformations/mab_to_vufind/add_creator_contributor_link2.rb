require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "../../../ulbd/record"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreatorContributorLink2 < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "author_link2_txt_mv", creator_contributor_link) : creator_contributor_link
  end

  private

  def creator_contributor_link
    creators = []

    creators << source.get("Personen2", include: "Überordnungen").map(&:get)
    
    creators << source.get("Körperschaften2", include: "Überordnungen").map(&:get)
 
    # Sonderfall: Verfasserangaben enthält [u.a.]
    #if source.get("Verantwortlichkeitsangaben").any? { |v| v.get.try(:[], /\.\.\.|\[u\.a\.\]/i) }
    #  creators << "[u.a.]"
    #end

    # Cleanup
    creators.flatten.map(&:presence).compact
  end
end
