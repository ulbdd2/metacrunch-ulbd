require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddInhaltstyp < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "inhaltstyp", inhaltstyp) : inhaltstyp
  end

  private

  def inhaltstyp
    f051  = source.controlfield('051')
    f052  = source.controlfield('052')
    f051s = f051.values.join.slice(1..3) || ""
    f052s = f052.values.join.slice(1..6) || ""

    type = case
    # Monos
    when (f051s.include?('b'))  then 'bibliography'
    when (f051s.include?('c'))  then 'catalog'
    when (f051s.include?('d'))  then 'dictionary'
    when (f051s.include?('e'))  then 'encyclopedia'
    when (f051s.include?('f'))  then 'festschrift'
    when (f051s.include?('h'))  then 'biography'
    when (f051s.include?('k'))  then 'congress'
    when (f051s.include?('m'))  then 'music'
    when (f051s.include?('n'))  then 'standard'
    when (f051s.include?('u'))  then 'university_text'
    when (f051s.include?('x'))  then 'textbook'
    when (f051s.include?('y'))  then 'dissertation'
    # Fortlaufende Sammelwerke (Zeitschriften u.ä.)
    when (f052s.include?('bi')) then 'bibliography'
    when (f052s.include?('ww')) then 'dissertation'
    when (f052s.include?('fs')) then 'festschrift'
    when (f052s.include?('ko')) then 'congress'
    when (f052s.include?('wb')) then 'dictionary'
    when (f052s.include?('ez')) then 'encyclopedia'
    when (f052s.include?('bg')) then 'biography'
    when (f052s.include?('mu')) then 'music'
    when (f052s.include?('no')) then 'standard'
    when (f052s.include?('sc')) then 'textbook'
    # ... der Rest
    else 'other'
    end

    type
  end
end
