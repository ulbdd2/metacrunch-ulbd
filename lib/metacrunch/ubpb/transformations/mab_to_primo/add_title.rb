require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/datafield_089"
require_relative "./helpers/merge"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddTitle < Transformator::Transformation::Step
  include parent::Helpers::Datafield089
  include parent::Helpers::Merge

  def call
    target ? MightyHash.add(target, "title", title) : title
  end

  private

  def title
    f331_2 = source.datafields('331', ind2: '2').subfields('a').value
    f333_2 = source.datafields('333', ind2: '2').subfields('a').value
    f335_2 = source.datafields('335', ind2: '2').subfields('a').value
    f360_2 = source.datafields('360', ind2: '2').subfields('a').value

    f089_1 = datafield_089.value
    f331_1 = source.datafields('331', ind2: '1').subfields('a').value
    f333_1 = source.datafields('333', ind2: '1').subfields('a').value
    f335_1 = source.datafields('335', ind2: '1').subfields('a').value
    f360_1 = source.datafields('360', ind2: '1').subfields('a').value
    f304_1 = source.datafields('304', ind2: '1').subfields('a').value
    f310_1 = source.datafields('310', ind2: '1').subfields('a').value
    f340_1 = source.datafields('340', ind2: '1').subfields('a').value
    f341_1 = source.datafields('341', ind2: '1').subfields('a').value

    title = merge(title, f331_2, delimiter: '. ')
    title = merge(title, f333_2, delimiter: ' / ')
    title = merge(title, f335_2, delimiter: ' : ')
    title = merge(title, f360_2, delimiter: '. ')

    title = merge(title, f089_1, delimiter: '. ')
    title = merge(title, f331_1, delimiter: '. ')
    title = merge(title, f333_1, delimiter: ' / ')
    title = merge(title, f335_1, delimiter: ' : ')
    title = merge(title, f360_1, delimiter: '. ')
    title = merge(title, f304_1, delimiter: '. ')
    title = merge(title, f310_1, delimiter: ' ', wrap: '[@]')
    title = merge(title, f340_1.presence || f341_1, delimiter: ' = ')

    title.presence || '–'
  end
end
