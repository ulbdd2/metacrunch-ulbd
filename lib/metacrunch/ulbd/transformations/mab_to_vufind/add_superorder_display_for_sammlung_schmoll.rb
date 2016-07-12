require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_signature_search"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSuperorderDisplayForSammlungSchmoll < Metacrunch::Transformator::Transformation::Step

  def call
    target ? Metacrunch::Hash.add(target, "superorder_display", superorder_display) : superorder_display
  end

  private

  def superorder_display
    superorders = []

    if signature_search.include?("ZZVS1009")
      superorders << {
        ht_number: nil,
        label: "Sammlung J. A. Schmoll gen. Eisenwerth",
        volume_count: nil,
        label_additions: nil
      }
    end

    superorders.map(&:to_json)
  end

  def signature_search
    target.try(:[], "signature_search") || self.class.parent::AddSignatureSearch.new(source: source).call
  end
end
