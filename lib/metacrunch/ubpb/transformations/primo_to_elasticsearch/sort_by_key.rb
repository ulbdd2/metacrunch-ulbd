require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::SortByKey < Metacrunch::Transformator::Transformation::Step
  def call
    transformation.target = target.sort.to_h
  end
end
