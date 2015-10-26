require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::RenameInhaltstypToInhaltstypFacet < Metacrunch::Transformator::Transformation::Step
  def call
    if inhaltstyp = target.delete("inhaltstyp")
      Metacrunch::Hash.add(target, "inhaltstyp_facet", inhaltstyp)
    end
  end
end
