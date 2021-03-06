require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_title"

class Metacrunch::ULBD::Transformations::MabToVufind::AddTitleSort < Metacrunch::Transformator::Transformation::Step
  def call
    Metacrunch::Hash.add(target, "title_sort", title_sort)
  end

  private

  def title_sort
    if title.present?
       title.gsub(/<<.*?>>/, '').gsub(/\s\s/, ' ').strip.downcase
    end
  end

  private

  def title
    target.try(:[], "title_simple") || self.class.parent::AddTitleSimple.new(source: source).call
  end
end
