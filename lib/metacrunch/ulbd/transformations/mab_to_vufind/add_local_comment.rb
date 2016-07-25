require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddLocalComment < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "local_comment_str", local_comment) : local_comment
  end

  private

  def local_comment
    source.datafields('125', ind1: ' ', ind2: ' ').subfields(['_', 'a']).values.flatten.uniq.presence
  end
end
