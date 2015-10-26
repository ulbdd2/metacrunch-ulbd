require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::AddLanguageFacet < Metacrunch::Transformator::Transformation::Step
  def call
    if language = target["language"]
      target["language_facet"] = language
    end
  end
end
