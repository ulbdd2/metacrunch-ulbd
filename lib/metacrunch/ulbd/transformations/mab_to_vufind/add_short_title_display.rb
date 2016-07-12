require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_short_title"

class Metacrunch::ULBD::Transformations::MabToVufind::AddShortTitleDisplay < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "short_title_display", short_title_display) : short_title_display
  end

  private

  def short_title_display
    if short_title.present?
      short_title.gsub(/<<|>>/, '')
    end
  end

  private

  def short_title
    target.try(:[], "short_title") || self.class.parent::AddShortTitle.new(source: source).call
  end
end
