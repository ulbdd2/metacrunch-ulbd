require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSublib < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "sublib_str_mv", sublib) : sublib
  end

  private

  def sublib
    
  sublib = []

        source.datafields('LOC').subfields('a').values.each do |single_sublib|
        sublib << single_sublib
    end
    
    sublib.compact.presence
    
  end
end
