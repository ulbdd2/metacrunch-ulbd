require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::AddCatalogingDate < Metacrunch::Transformator::Transformation::Step
  def call
    begin
      if (last_creation_date = [source["creation_date"]].flatten.compact.last)
        if cataloging_date = Date.strptime(last_creation_date, "%Y%m%d").iso8601 rescue ArgumentError
          target["cataloging_date"] = cataloging_date
        end
      end
    rescue
      binding.pry
    end
  end
end
