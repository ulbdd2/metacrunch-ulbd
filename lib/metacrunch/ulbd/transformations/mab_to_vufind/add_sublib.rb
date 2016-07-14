require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSublib < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "sublib_str", sublib) : sublib
  end

  private

  def sublib
    source.datafields('LOC').subfields('a').value
  end
end
