require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/datafield_1xx"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCreatorContributorDisplay < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::Datafield1XX

  def call
    target ? MightyHash.add(target, "creator_contributor_display", creator_contributor_display) : creator_contributor_display
  end

  private

  def creator_contributor_display
    creators = []

    # Personen
    creators << datafield_1xx.values

    # Körperschaften
    (200..296).step(4) do |f|
      creators << source.datafields("#{f}", ind2: ['1', '2']).map { |_field| _field.subfields(['a','k','b','e','n','c','g','h']).values.presence.try(:join, " ") }
    end

    # Sonderfall: Verfasserangaben aus 359 -> [u.a.]
    t = source.datafields("359", ind2: '1').subfields('a').value
    creators << '[u.a.]' if t && t.match(/\.\.\.|\[u\.a\.\]/i)

    # Cleanup
    creators = creators.flatten.compact
    creators = creators.map{ |c| c.delete('<').delete('>') }
    creators = creators.map(&:presence).compact.uniq
  end
end
