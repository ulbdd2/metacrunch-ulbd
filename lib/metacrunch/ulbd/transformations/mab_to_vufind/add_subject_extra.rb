require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSubjectExtra < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "topic_extra", subjects) : subjects
  end

  private

  def subjects
    subjects = []

    #subjects2 << source.datafields('902').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('907').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('912').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('917').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('922').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('927').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('932').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('937').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('942').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    #subjects2 << source.datafields('947').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
 
    # Beispiel aus 740: New York (N.Y.)--Social life and customs--20th century--Fiction.
    %w(710 740).each do |f|
      t = source.datafields(f).subfields(['a','x','z']).values
      t = t.flatten.map(&:presence).compact
      t = t.map{|a| a.split('--')}.flatten.map{|s| s.end_with?('.') ? s[0..-2].strip : s}.map(&:presence).compact.uniq
      subjects = subjects + t
    end
      
      %w(G10 G40).each do |f|
      t = source.datafields(f).subfields(['a','x','z']).values
      t = t.flatten.map(&:presence).compact
      t = t.map{|a| a.split('--')}.flatten.map{|s| s.end_with?('.') ? s[0..-2].strip : s}.map(&:presence).compact.uniq
      subjects = subjects + t
    end
    
     %w(711).each do |f|
      u = source.datafields(f).subfields('a').values
      u = u.flatten.map(&:presence).compact
      u = u.map{|a| a.split('--')}.flatten.map{|s| s.end_with?('.') ? s[0..-2].strip : s}.map(&:presence).compact.uniq
      subjects = subjects + u
    end
    
    %w(G11).each do |f|
      u = source.datafields(f).subfields('a').values
      u = u.flatten.map(&:presence).compact
      u = u.map{|a| a.split('--')}.flatten.map{|s| s.end_with?('.') ? s[0..-2].strip : s}.map(&:presence).compact.uniq
      subjects = subjects + u
    end

    subjects.flatten.map(&:presence).compact.map{|f| f.delete('<').delete('>')}.uniq
  end
end