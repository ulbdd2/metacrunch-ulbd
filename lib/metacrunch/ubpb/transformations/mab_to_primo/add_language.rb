require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddLanguage < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "language", language) : language
  end

  private

  def language
    languages = []
    languages << source.datafields('037', ind1: 'b', ind2: ['1','2']).subfields('a').values
    languages.flatten.map(&:presence).compact.uniq
  end
end
