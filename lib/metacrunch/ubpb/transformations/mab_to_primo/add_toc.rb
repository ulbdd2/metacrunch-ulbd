require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddToc < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "toc", toc) : toc
  end

  private

  def toc
    source.datafields('TXT').subfields('a').values.join(' ')
  end
end