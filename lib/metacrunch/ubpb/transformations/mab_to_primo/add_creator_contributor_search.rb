require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./add_creator_contributor_display"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCreatorContributorSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "creator_contributor_search", creator_contributor_search) : creator_contributor_search
  end

  private

  def creator_contributor_search
    creators = []

    # Alle aus dem Display
    creators = creators + [creator_contributor_display].flatten(1).compact
    # Entferne Sonderfall [u.a.]
    creators.reject!{|e| e == '[u.a.]'}

    # + Index Felder für Personen
    creators << source.datafields('PPE').subfields(['a', 'p']).values

    # + zweiteilige Nebeneintragungen / beigefügte oder enthaltene Werke
    (800..824).step(6) do |f|
      creators << source.datafields("#{f}").subfields(['a','p','c','n','b']).values
    end

    # + Index Felder für Körperschaften
    creators << source.datafields('PKO').subfields(['a','k','b','e','g']).values

    # Füge alle Teile zusammen
    creators = creators.flatten.compact
    # Lösche Sortierzeichen
    creators = creators.map{ |c| c.delete('<').delete('>') }
    # Prüfe Inhalte auf Existenz und entferne doppelte Einträge
    creators = creators.map(&:presence).compact.uniq
  end

  private

  def creator_contributor_display
    target.try(:[], "creator_contributor_display") || self.class.parent::AddCreatorContributorDisplay.new(source: source).call
  end
end
