require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddLocalComment < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "local_comment", local_comment) : local_comment
  end

  private

  def local_comment
    source.datafields('125', ind1: ' ', ind2: ' ').subfields(['_', 'a']).values.flatten.uniq.presence
  end
end
