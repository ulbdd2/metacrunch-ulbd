    require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddExDescriptionLocal < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "ex_desc_local_txt_mv", exdesclocal) : exdesclocal
  end

  private

  def exdesclocal
    
    exdescl = []
    exdescl << source.datafields('125', ind1: 'a', ind2: '9').subfields('a').values
    exdescl.flatten.map(&:presence).compact.uniq
     
    # 125 - Bemerkungen aus Lokalsatz
    #source.datafields('125', ind1: 'a', ind2: '9').subfields('a').value
  end
end
    
 
   