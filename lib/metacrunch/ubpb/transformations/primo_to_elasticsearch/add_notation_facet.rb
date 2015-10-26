require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::AddNotationFacet < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "notation_facet", notation_facet) : notation_facet
  end

  private

  def notation_facet
    source["notation"]
  end
end
