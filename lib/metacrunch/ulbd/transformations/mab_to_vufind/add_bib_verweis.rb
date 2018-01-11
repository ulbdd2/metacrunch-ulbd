    require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddBibVerweis < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "bib_verweis_txt_mv", bibverweis) : bibverweis
  end

  private

  def bibverweis
    
    bibv = []
    bibv << source.datafields('580', ind2: '1').subfields('a').values
    bibv.flatten.map(&:presence).compact.uniq
     
    #580 - Sonstige Standardnummer
    #source.datafields('580', ind2: '1').subfields('a').value
  end
end
   