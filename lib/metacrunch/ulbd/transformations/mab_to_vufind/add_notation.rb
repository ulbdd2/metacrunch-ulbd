require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddNotation < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "notation_facet", notation) : notation
  end

  private

  def notation
    
    notations = []
    
    source.datafields('700', ind1: 'h', ind2: ['1', '2']).subfields('a').values.uniq.each do |single_notation|
      if (single_notation =~ /^F?B?[a-z]{4}\d{3,5}/)
        notations << single_notation
      end
    end
    
    notations.compact.presence
  end
end
