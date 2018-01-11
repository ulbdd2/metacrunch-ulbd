require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddDrunorm < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "druck_normiert_txt_mv", drunormiert) : drunormiert
  end

  private

  def drunormiert
    drunor = []

    drunor << source.datafields('677').subfields(['k','g','b','n','h','x','z','p','n','c','d']).values
    

    drunor.flatten.map(&:presence).compact.map{|f| f.delete('<').delete('>')}.uniq
  end
end
