require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/corporate_body_from_field"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCorporateBodyCreatorDisplay < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::CorporateBodyFromField
  
  def call
    target ? Metacrunch::Hash.add(target, "corporate_body_creator_display", corporate_body_creator_display) : corporate_body_creator_display
  end

  private

  def corporate_body_creator_display
    creators = []

    # Körpferschaften
    (200..296).step(4) do |f|
      # although all docs state that there is no indicator 'a', samples show that it is
      source.datafields("#{f}", ind1: [:blank, 'a'], ind2: ['1', '2']).each do |field|
        creators << corporate_body_from_field(field)
      end
    end

    creators.map(&:presence).compact.uniq
  end
end
