require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::ReplaceTitleWithShortTitleDisplay < Metacrunch::Transformator::Transformation::Step
  def call
    target["title"] = target.delete("short_title_display")
  end
end
