require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddFingerprint < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "fingerprint_txt", fingerprint) : fingerprint
  end

  private

  def fingerprint
        source.datafields('578', ind2: '1').subfields('a').value
  end
end
