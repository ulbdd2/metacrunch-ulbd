require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddProvenienz < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "provenienz_txt_mv", provenienz) : provenienz
  end

  private

  def provenienz
    prov = []
    prov << source.datafields('132', ind1: 'p',  ind2: '9').subfields('a').values
    prov.flatten.map(&:presence).compact.uniq
  end
end
