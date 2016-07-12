require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddAbstract < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "abstract", abstract) : abstract
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
