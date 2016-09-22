require "metacrunch/hash" 
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddPlk < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "plk_txt", plk) : plk
  end

  private

  def plk
    value = 'false'


    value = 'true' if source.datafields('PLK').subfields('a').values.flatten.any? { |v| v.include? 'DN' }
    value = 'true' if source.datafields('PLK').subfields('a').values.flatten.any? { |v| v.include? 'SRD' }
    
    value
  end
end
