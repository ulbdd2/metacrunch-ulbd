require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./helpers/datafield_1xx"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddPersonContributorDisplay < Transformator::Transformation::Step
  include parent::Helpers::Datafield1XX

  def call
    target ? MightyHash.add(target, "person_contributor_display", person_contributor_display) : person_contributor_display
  end

  private

  def person_contributor_display
    contributors = []

    # Personen
    contributors.concat(datafield_1xx(ind1: ['b', 'c', 'e', 'f'], ind2: ['1', '2']).values)

    contributors.uniq.uniq.map { |element| element.gsub(/<<|>>/, '') }
  end
end
