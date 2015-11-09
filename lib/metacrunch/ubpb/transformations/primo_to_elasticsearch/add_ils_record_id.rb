require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::AddIlsRecordId < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "ils_record_id", ils_record_id) : ils_record_id
  end

  private

  def ils_record_id
    source["id"]
  end
end
