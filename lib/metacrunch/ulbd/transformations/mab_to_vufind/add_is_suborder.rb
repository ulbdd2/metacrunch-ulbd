require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_superorder_display"

class Metacrunch::ULBD::Transformations::MabToVufind::AddIsSuborder < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "is_suborder", is_suborder) : is_suborder
  end

  private

  def is_suborder
    superorder_display.present? # we take superorder_display instead of superorder to exclude superorder relations between primary/secondare form from this indicator
  end

  private

  def superorder_display
    target.try(:[], "superorder_display") || self.class.parent::AddSuperorderDisplay.new(source: source).call
  end
end
