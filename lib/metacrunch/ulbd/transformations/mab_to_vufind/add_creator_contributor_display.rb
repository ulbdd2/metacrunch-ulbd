require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "../../../ulbd/record"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreatorContributorDisplay < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "author", creator_contributor_display) : creator_contributor_display
  end

  private

  def creator_contributor_display
    creators = []

    creators << source.get("Personen", include: "Überordnungen").map do |p|
      p.get(include: ["Beziehungskennzeichnungen", "ausgeschriebene Funktionsbezeichnung"])
    end

    creators << source.get("Körperschaften", include: "Überordnungen").map do |k|
      k.get(include: "Beziehungskennzeichnungen")
    end

    # Sonderfall: Verfasserangaben enthält [u.a.]
    if source.get("Verantwortlichkeitsangaben").any? { |v| v.get.try(:[], /\.\.\.|\[u\.a\.\]/i) }
      creators << "[u.a.]"
    end

    # Cleanup
    creators.flatten.map(&:presence).compact.uniq.join('; ')
  end
end
