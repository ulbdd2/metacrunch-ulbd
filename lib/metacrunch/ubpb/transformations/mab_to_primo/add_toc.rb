require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddToc < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "toc", toc) : toc
  end

  private

  def toc
    source.datafields('TXT').subfields('a').values.join(' ')
  end
end
