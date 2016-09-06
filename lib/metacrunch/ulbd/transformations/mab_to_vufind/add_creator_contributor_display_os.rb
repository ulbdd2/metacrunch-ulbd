require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "../../../ulbd/record"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreatorContributorDisplayOs < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "author_os_txt_mv", creator_contributor_display_os) : creator_contributor_display_os
  end

  private

  def creator_contributor_display_os
    creators = []

    creators << source.get("Personen Os", include: "Überordnungen").map do |p|
      p.get(include: ["Beziehungskennzeichnungen", "ausgeschriebene Funktionsbezeichnung"])
    end

    creators << source.get("Körperschaften Os", include: "Überordnungen").map do |k|
      k.get(include: "Beziehungskennzeichnungen")
    end

        
    # Cleanup
    creators.flatten.map(&:presence).compact.uniq
  end
end
