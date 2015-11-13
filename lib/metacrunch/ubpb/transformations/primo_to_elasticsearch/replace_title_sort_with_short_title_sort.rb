require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::ReplaceTitleSortWithShortTitleSort < Metacrunch::Transformator::Transformation::Step
  def call
    target["title_sort"] = target.delete("short_title_sort")
  end
end
