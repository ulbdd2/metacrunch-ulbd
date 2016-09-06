require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddEditionOs < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "edition_os", edition_os) : edition_os
  end

  private

  def edition_os
    fD03_1 = source.datafields('D03', ind2: '1').subfields('a').value
    fD03_2 = source.datafields('D03', ind2: '2').subfields('a').value
    fD07_1 = source.datafields('D07', ind2: '1').subfields('a').value
    fD07_2 = source.datafields('D07', ind2: '2').subfields('a').value

    fD03_1.presence || fD03_2.presence || fD07_1.presence || fD07_2.presence
  end
end
