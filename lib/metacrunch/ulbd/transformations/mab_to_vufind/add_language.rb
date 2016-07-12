require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddLanguage < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "language", language) : language
  end

  private

  def language
    languages = []
    languages << source.datafields('037', ind1: 'b', ind2: ['1','2']).subfields('a').values
    languages.flatten.map(&:presence).compact.uniq
  end
end
