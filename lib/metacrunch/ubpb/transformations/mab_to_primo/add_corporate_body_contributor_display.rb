require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/corporate_body_from_field"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCorporateBodyContributorDisplay < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::CorporateBodyFromField
  
  def call
    target ? Metacrunch::Hash.add(target, "corporate_body_contributor_display", corporate_body_contributor_display) : corporate_body_contributor_display
  end

  private

  def corporate_body_contributor_display
    contributors = []

    # Körpferschaften
    (200..296).step(4) do |f|
      source.datafields("#{f}", ind1: ['b', 'c', 'e'], ind2: ['1', '2']).each do |field|
        contributors << corporate_body_from_field(field)
      end
    end

    contributors.map(&:presence).compact.uniq
  end
end
