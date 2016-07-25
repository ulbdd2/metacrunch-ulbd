require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_is_suborder"

class Metacrunch::ULBD::Transformations::MabToVufind::AddErscheinungsform < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "format", erscheinungsform) : erscheinungsform
  end

  private

  def erscheinungsform
    f051  = source.controlfield('051')
    f052  = source.controlfield('052')
    f051s = f051.values.join.slice(1..3) || ""
    f052s = f052.values.join.slice(1..6) || ""

    type = case
    when (f051.at(0) == 'a') then 'Article'
    when (f051.at(0) == 'm') then 'Book'
    when (f051.at(0) == 'n') then 'Book'
    when (f051.at(0) == 's') then 'Book'
    when (f051.at(0) == 't') then 'Book'

    when (f052.at(0) == 'a') then 'Article'
    when (f052.at(0) == 'p') then 'Journal'
    when (f052.at(0) == 'r') then 'Series'
    when (f052.at(0) == 'z') then 'Newspaper'

    when (f051s.include?('t'))  then 'Article'
    when (f052s.include?('au')) then 'Article'
    when (f052s.include?('se')) then 'Series'
    # ... der Rest
    else
      #
      # Hack to make all suborders without proper 'erscheinungsform' monographs
      #
      if is_suborder.presence
        'Book'
      else
        'Other'
      end
    end

    type
  end

  private

  def is_suborder
    target.try(:[], "is_suborder") || self.class.parent::AddIsSuborder.new(source: source).call
  end
end
