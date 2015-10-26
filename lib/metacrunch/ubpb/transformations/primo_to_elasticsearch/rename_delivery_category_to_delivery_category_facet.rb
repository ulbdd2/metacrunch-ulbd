require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::RenameDeliveryCategoryToDeliveryCategoryFacet < Metacrunch::Transformator::Transformation::Step
  def call
    if delivery_category = target.delete("delivery_category")
      Metacrunch::Hash.add(target, "delivery_category_facet", delivery_category)
    end
  end
end
