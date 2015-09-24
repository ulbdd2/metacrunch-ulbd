require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./add_title"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddTitleSort < Metacrunch::Transformator::Transformation::Step
  def call
    MightyHash.add(target, "title_sort", title_sort)
  end

  private

  def title_sort
    title.gsub(/<<.*>>/, '').gsub(/\s\s/, ' ').strip
  end

  private

  def title
    target.try(:[], "title") || self.class.parent::AddTitle.new(source: source).call
  end
end
