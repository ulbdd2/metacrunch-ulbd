require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddMaterialtyp < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "materialtyp", materialtyp) : materialtyp
  end

  private

  def materialtyp
    f050 = source.controlfield('050')
    type = case
    when (%w(a    ).include?(f050.at( 0)) ) then 'print'
    when (%w(a b c).include?(f050.at( 3)) ) then 'microform'
    when (%w(a    ).include?(f050.at( 5)) ) then 'audio'
    when (%w(b c z).include?(f050.at( 5)) ) then 'video'
    when (%w(d    ).include?(f050.at( 5)) ) then 'image'
    when (%w(d    ).include?(f050.at( 8)) ) then 'data_storage'
    when (%w(g    ).include?(f050.at( 8)) ) then 'online_resource'
    when (%w(a    ).include?(f050.at( 9)) ) then 'game'
    when (%w(a    ).include?(f050.at(10)) ) then 'map'
    else 'other'
    end
    type
  end
end
