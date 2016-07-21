require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_erscheinungsform"
require_relative "./add_materialtyp"

class Metacrunch::ULBD::Transformations::MabToVufind::AddDeliveryCategory < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "delivery_category_str", delivery_category) : delivery_category
  end

  private

  def delivery_category
    if (materialtyp == 'online_resource')
      'electronic_resource'
    elsif (erscheinungsform == 'series' || erscheinungsform == 'journal')
      'structural_metadata'
    else
      'physical_item'
    end
  end

  private

  def erscheinungsform
    target.try(:[], "erscheinungsform") || self.class.parent::AddErscheinungsform.new(source: source).call
  end

  def materialtyp
    target.try(:[], "materialtyp") || self.class.parent::AddMaterialtyp.new(source: source).call
  end
end
