require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./add_creationdate"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddCreationdateSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "creationdate_search", creationdate_search) : creationdate_search
  end

  private

  def creationdate_search
    if date = creationdate
      date.gsub(/[^0-9]/i, '') # Entferne alle nicht numerischen Zeichen
    end
  end

  private

  def creationdate
    target.try(:[], "creationdate") || self.class.parent::AddCreationdate.new(source: source).call
  end
end
