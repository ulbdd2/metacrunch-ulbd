require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddRedactionalRemark < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "redactional_remark", redactional_remark) : redactional_remark
  end

  private

  def redactional_remark
    source.datafields("537", ind2: '1').map do |_datafield|
      _datafield.subfields(['a', 'p']).values.join(': ')
    end
    .presence.try(:join)
  end
end
