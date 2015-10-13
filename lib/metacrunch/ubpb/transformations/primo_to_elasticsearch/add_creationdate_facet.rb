require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::AddCreationdateFacet < Metacrunch::Transformator::Transformation::Step
  def call
    if creationdate = target["creationdate"].try(:[], /\d{4}/)
      target["creationdate_facet"] = creationdate.to_i
    end
  end
end
