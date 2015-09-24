require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddIsSecondaryForm < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "is_secondary_form", is_secondary_form) : is_secondary_form
  end

  private

  def is_secondary_form
    !!(source.datafields('610').value || source.datafields('611').value || source.datafields('619').value || source.datafields('621').value || source.datafields('649').value)
  end
end
