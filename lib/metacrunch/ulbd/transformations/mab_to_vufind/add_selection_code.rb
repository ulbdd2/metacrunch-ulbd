require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSelectionCode < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "selection_code_txt_mv", selection_code) : selection_code
  end

  private

  def selection_code
    codes = []
    codes << source.datafields('078', ind1: 'e').subfields('a').values
    codes << source.datafields('078', ind1: ' ', ind2: '9').subfields('a').values    
        source.datafields('ERW').subfields('a').values.each { |zs| 
        if (zs == "zsmagex"); codes << 'zsmagex' 
        end }
    codes.flatten.map(&:presence).compact.uniq
  end 
end
