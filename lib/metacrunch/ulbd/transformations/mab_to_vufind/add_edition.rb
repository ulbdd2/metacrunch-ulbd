require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddEdition < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "edition", edition) : edition
  end

  private

  def edition
    f403_1 = source.datafields('403', ind2: '1').subfields('a').value
    f403_2 = source.datafields('403', ind2: '2').subfields('a').value
    f407_1 = source.datafields('407', ind2: '1').subfields('a').value

    f403_1.presence || f403_2.presence || f407_1.presence
  end
end
