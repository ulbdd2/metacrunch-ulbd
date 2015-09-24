require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./add_creator_contributor_display"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCreatorContributorFacet < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "creator_contributor_facet", creator_contributor_facet) : creator_contributor_facet
  end

  private

  def creator_contributor_facet
    if creator_contributor_display.present?
      [creator_contributor_display].flatten(1).compact.map { |creator_contributor| creator_contributor.gsub(/\[.*\]/, '').strip.presence }.compact.presence
    end
  end

  private

  def creator_contributor_display
    target.try(:[], "creator_contributor_display") || self.class.parent::AddCreatorContributorDisplay.new(source: source).call
  end
end
