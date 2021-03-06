require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::RenameMaterialtypToMaterialtypFacet < Metacrunch::Transformator::Transformation::Step
  def call
    if materialtyp = target.delete("materialtyp")
      Metacrunch::Hash.add(target, "materialtyp_facet", materialtyp)
    end
  end
end
