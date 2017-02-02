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
    f051s = f051.values.slice(1) || ""
    f051t = f051.values.slice(2) || ""
    f051u = f051.values.slice(3) || ""
    f052s = f052.values.slice(1) || ""
    f052t = f052.values.slice(2) || ""
    f052u = f052.values.slice(3) || ""
    f052v = f052.values.slice(4) || ""
    f052w = f052.values.slice(5) || ""
    f052x = f052.values.slice(6) || ""
    
    type = case
    when (f051.at(0) == 'a') then 'Article'
    when (f051.at(0) == 'm') then 'Book'
    when (f051.at(0) == 'n') then 'Series'
    when (f051.at(0) == 's') then 'Book'
    when (f051.at(0) == 't') then 'Series'

    when (f052.at(0) == 'a') then 'Article'
    when (f052.at(0) == 'i') then 'CIR' 
    when (f052.at(0) == 'p') then 'Journal'
    when (f052.at(0) == 'r') then 'Series'
    when (f052.at(0) == 'z') then 'Newspaper'

    when (f051s.include?('t') || f051t.include?('t') || f051u.include?('t'))  then 'Article'
    when (f052s.include?('a') && f052t.include?('u')) || (f052u.include?('a') && f052v.include?('u')) || (f052w.include?('a') && f052x.include?('u')) then 'Article'
    when (f052s.include?('s') && f052t.include?('e')) || (f052u.include?('s') && f052v.include?('e')) || (f052w.include?('s') && f052x.include?('e')) then 'Series'
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
