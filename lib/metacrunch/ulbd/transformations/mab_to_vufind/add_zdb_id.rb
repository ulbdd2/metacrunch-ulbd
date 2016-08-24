require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddZdbId < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "zdb_id_txt_mv", zdb_id) : zdb_id
  end

  private

  def zdb_id
    zdb_ids = []
    zdb_ids << source.datafields('025', ind1: 'z',  ind2: '1').subfields('a').values
    zdb_ids.flatten.map(&:presence).compact.uniq
  end
end
