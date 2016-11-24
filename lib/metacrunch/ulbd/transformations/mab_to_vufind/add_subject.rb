require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSubject < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "topic", subject) : subject
  end

  private

  def subject
    subjects = []

    subjects << source.datafields('902').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('907').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('912').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('917').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('922').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('927').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('932').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('937').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('942').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('947').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
 
    # Beispiel aus 740: New York (N.Y.)--Social life and customs--20th century--Fiction.
    %w(DES).each do |f|
      t = source.datafields(f).subfields(['a','x','z']).values
      t = t.flatten.map(&:presence).compact
      t = t.map{|a| a.split('--')}.flatten.map{|s| s.end_with?('.') ? s[0..-2].strip : s}.map(&:presence).compact.uniq
      subjects = subjects + t
    end
      
    #  %w(DES G10 G40).each do |f|
    #  t = source.datafields(f).subfields(['a','x','z']).values
    #  t = t.flatten.map(&:presence).compact
    #  t = t.map{|a| a.split('--')}.flatten.map{|s| s.end_with?('.') ? s[0..-2].strip : s}.map(&:presence).compact.uniq
    #  subjects = subjects + t
    #end
    
     #%w(DES 711).each do |f|
     # u = source.datafields(f).subfields('a').values
     # u = u.flatten.map(&:presence).compact
     # u = u.map{|a| a.split('--')}.flatten.map{|s| s.end_with?('.') ? s[0..-2].strip : s}.map(&:presence).compact.uniq
     # subjects = subjects + u
    #end
    
    #%w(DES G11).each do |f|
    #  u = source.datafields(f).subfields('a').values
    #  u = u.flatten.map(&:presence).compact
    #  u = u.map{|a| a.split('--')}.flatten.map{|s| s.end_with?('.') ? s[0..-2].strip : s}.map(&:presence).compact.uniq
    #  subjects = subjects + u
    #end

    subjects.flatten.map(&:presence).compact.map{|f| f.delete('<').delete('>')}.uniq
  end
end
