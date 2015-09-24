require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/datafield_1xx"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddPersonCreatorDisplay < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::Datafield1XX

  def call
    target ? MightyHash.add(target, "person_creator_display", person_creator_display) : person_creator_display
  end

  private

  def person_creator_display
    creators = []

    # Personen
    creators.concat(datafield_1xx(ind1: ['-', 'a'], ind2: ['1', '2']).values)

    creators.uniq.map { |element| element.gsub(/<<|>>/, '') }
  end
end
