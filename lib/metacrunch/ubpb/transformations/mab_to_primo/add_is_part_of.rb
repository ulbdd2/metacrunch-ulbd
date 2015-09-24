require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/merge"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddIsPartOf < Transformator::Transformation::Step
  include parent::Helpers::Merge

  def call
    target ? MightyHash.add(target, "is_part_of", is_part_of) : is_part_of
  end

  private

  def is_part_of
    f525 =
    source.datafields('525', ind2: '1').map do |_field|
      _field.subfields(['p','a']).values.presence.try(:join, ': ')
    end
    .first

    f590   = source.datafields('590', ind2: '1').subfields('a').value
    f591   = source.datafields('591', ind2: '1').subfields('a').value
    f592   = source.datafields('592', ind2: '1').subfields('a').value
    f593   = source.datafields('593', ind2: '1').subfields('a').value
    f594   = source.datafields('594', ind2: '1').subfields('a').value
    f595   = source.datafields('595', ind2: '1').subfields('a').value
    f596   = source.datafields('596', ind2: '1').subfields('a').value
    f597   = source.datafields('597', ind2: '1').subfields('a').value
    f598   = source.datafields('598', ind2: '1').subfields('a').value

    #f599_1 = doc.datafield('599', ind1: 'a,b', ind2: '1', subfield: 'a', multiple: true).join(' ') # ISSN
    #f599_2 = doc.datafield('599', ind1: 'c,d', ind2: '1', subfield: 'a', multiple: true).join(' ') # ISBN
    #f599_3 = doc.datafield('599', ind1: 'e,f', ind2: '1', subfield: 'a', multiple: true).join(' ') # ISMN
    #f599_4 = doc.datafield('599', ind1: 'g,h', ind2: '1', subfield: 'a', multiple: true).join(' ') # ISRN

    ipo = f525
    ipo = merge(ipo, f590,   delimiter: '.- ', wrap: "In: @" )
    ipo = merge(ipo, f591,   delimiter: ' / '                )
    ipo = merge(ipo, f592,   delimiter: '. '                 )
    ipo = merge(ipo, f593,   delimiter: '.- '                )
    ipo = merge(ipo, f594,   delimiter: '.- '                )
    ipo = merge(ipo, f595,   delimiter: ', '                 )
    ipo = merge(ipo, f596,   delimiter: '.- '                )
    ipo = merge(ipo, f597,   delimiter: '.- ', wrap: "(@)"   )
    ipo = merge(ipo, f598,   delimiter: '.- '                )

    #ipo = merge(ipo, f599_1, delimiter: '.- ', wrap: "ISSN @")
    #ipo = merge(ipo, f599_2, delimiter: '.- ', wrap: "ISSN @")
    #ipo = merge(ipo, f599_3, delimiter: '.- ', wrap: "ISMN @")
    #ipo = merge(ipo, f599_4, delimiter: '.- ', wrap: "ISRN @")

    ipo.presence
  end
end
