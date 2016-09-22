require "metacrunch/hash" 
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddPlkIpo < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "plk_ipo_txt", plk_ipo) : plk_ipo
  end

  private

  def plk_ipo
    value = 'false'

    value = 'true' if source.datafields('PLK').subfields('a').values.flatten.any? { |v| v.include? 'AND' }
   
    value
end
end