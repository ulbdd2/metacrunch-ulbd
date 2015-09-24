require "mighty_hash" 
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddAuthorStatement < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "author_statement", author_statement) : author_statement
  end

  private

  def author_statement
    f359_1 = source.datafields('359', ind1: :blank, ind2:'1').subfields('a').values.flatten.presence
    f359_2 = source.datafields('359', ind1: :blank, ind2:'2').subfields('a').values.flatten.presence
    f359_1 || f359_2
  end
end
