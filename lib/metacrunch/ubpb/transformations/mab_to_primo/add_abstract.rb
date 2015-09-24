require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddAbstract < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "abstract", abstract) : abstract
  end

  private

  def abstract
    abstracts = []

    abstracts << source.datafields('750').subfields('a').value
    abstracts << source.datafields('753').subfields('a').value
    abstracts << source.datafields('756').subfields('a').value

    abstracts.map(&:presence).compact
  end
end
