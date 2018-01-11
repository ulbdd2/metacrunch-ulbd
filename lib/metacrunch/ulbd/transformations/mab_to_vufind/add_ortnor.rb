require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddOrtnor < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "ort_normiert_txt_mv", ortnormiert) : ortnormiert
  end

  
private

  def ortnormiert
    ortnor = []

    ortnor << source.datafields('676').subfields(['g','h','z','x']).values
    

    ortnor.flatten.map(&:presence).compact.map{|f| f.delete('<').delete('>')}.uniq
  end
end

