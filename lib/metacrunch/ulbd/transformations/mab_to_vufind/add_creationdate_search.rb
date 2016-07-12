require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_creationdate"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreationdateSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "creationdate_search", creationdate_search) : creationdate_search
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
