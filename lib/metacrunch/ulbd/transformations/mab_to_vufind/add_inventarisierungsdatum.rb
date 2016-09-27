require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddInventarisierungsdatum < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "inventarisierungsdatum_txt_mv", invdat) : invdat
  end

  private

  def invdat
    r = []
    
    source.datafields('LOC').each do |field|
      field_q = field.subfields('q').value

      
      r << field_q
    end
    
    r.map(&:presence).compact.uniq
  end
end
