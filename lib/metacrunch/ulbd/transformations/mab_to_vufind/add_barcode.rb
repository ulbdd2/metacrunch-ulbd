require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddBarcode < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "barcode_txt_mv", barcode) : barcode
  end

  private

  def barcode
    source.datafields('LOC').subfields('5').values.uniq
  end
end
