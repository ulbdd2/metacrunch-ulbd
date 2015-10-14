require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./add_short_title"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddShortTitleSort < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "short_title_sort", short_title_sort) : short_title_sort
  end

  private

  def short_title_sort
    if short_title.present?
      short_title.gsub(/<<[^>]*>>/, "").strip.presence
    end
  end

  private

  def short_title
    target.try(:[], "short_title") || self.class.parent::AddShortTitle.new(source: source).call
  end
end
