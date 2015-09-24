require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/merge"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddFormat < Transformator::Transformation::Step
  include parent::Helpers::Merge

  def call
    target ? MightyHash.add(target, "format", format) : format
  end

  private

  def format
    f433 = source.datafields('433', ind2: '1').subfields('a').value
    f434 = source.datafields('434', ind2: '1').subfields('a').values.join(', ')
    f435 = source.datafields('435', ind2: '1').subfields('a').value
    f437 = source.datafields('437', ind2: '1').subfields('a').value
    f653 = source.datafields('653', ind2: '1').subfields('a').values.join(', ')

    format = f433
    format = merge(format, f434, delimiter: ' : ')
    format = merge(format, f435, delimiter: ' ; ')
    format = merge(format, f437, delimiter: ' + ')
    format = merge(format, f653, delimiter: '.- ')

    format.presence
  end
end
