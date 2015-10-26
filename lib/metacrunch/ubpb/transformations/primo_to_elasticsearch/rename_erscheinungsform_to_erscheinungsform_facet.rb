require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::RenameErscheinungsformToErscheinungsformFacet < Metacrunch::Transformator::Transformation::Step
  def call
    if erscheinungsform = target.delete("erscheinungsform")
      Metacrunch::Hash.add(target, "erscheinungsform_facet", erscheinungsform)
    end
  end
end
