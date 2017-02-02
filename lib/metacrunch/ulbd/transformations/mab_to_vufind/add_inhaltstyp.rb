require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddInhaltstyp < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "inhaltstyp_facet", inhaltstyp) : inhaltstyp
  end

  private

  def inhaltstyp
    
    inhalt = []
    
    inhalt << format
    
    source.datafields('LOC').subfields('d').values.uniq.each do |iht|
      source.datafields('LOC').subfields('m').values.uniq.each { |pic| 
        if (iht =~ /^pla/); inhalt << 'plakat' 
        elsif (iht =~ /^q/); inhalt << 'schulprogramm'
        elsif (pic == "BILD"); inhalt << 'image' end }
    end
    
    source.datafields('064', ind1: 'a', ind2: '1').subfields('a').values.uniq.each do |bibl|
      inhalt << 'bibliography' if (bibl == "Bibliografie")
      inhalt << 'catalog' if (bibl =~ /.*katalog/)
      inhalt << 'congress' if (bibl == "Konferenzschrift")
      inhalt << 'dictionary' if (bibl =~ /.*örterbuch/)
      inhalt << 'encyclopedia' if (bibl == "Enzyklopädie")
      inhalt << 'biography' if (bibl =~ /.*iografie/)
      inhalt << 'festschrift' if (bibl == "Festschrift")
      inhalt << 'statistics' if (bibl == "Statistik")
      inhalt << 'lawreport' if (bibl == "Entscheidungssammlung")
      inhalt << 'plakat' if (bibl == "Plakat")
    end
    
    source.datafields('334', ind1: '-', ind2: '1').subfields('a').values.uniq.each do |mate|
      inhalt << 'audio' if (mate == "Tonträger")
      inhalt << 'video' if (mate == "Bildtonträger")
      inhalt << 'music' if (mate == "Musikdruck")
      inhalt << 'image' if (mate == "Bildliche Darstellung")
    end
    
    source.datafields('DES', ind1: '-', ind2: '1').subfields('a').values.uniq.each do |thea|
    source.datafields('334', ind1: '-', ind2: '1').subfields('a').values.each do |bild|
      if (thea == "Theaterzettel")
        inhalt << 'theaterzettel'
      elsif (thea == "Plakat" && bild == "Bildliche Darstellung") 
        inhalt << 'plakat'
      end
    end
    end
    
    source.datafields('510', ind1: '-', ind2: '1').subfields('a').values.uniq.each do |thea|
      inhalt << 'theaterzettel' if (thea == "Theaterzettel")
    end
    
    source.datafields('060', ind1: '-', ind2: '1').subfields('b').values.uniq.each do |ntm|
      inhalt << 'music' if (ntm == "ntm")
    end
    
    source.datafields('061', ind1: '-', ind2: '1').subfields('b').values.uniq.each do |medi|
      inhalt << 'audio' if (medi == "s")
      inhalt << 'video' if (medi == "v")
    end
    
    source.datafields('078', ind1: '-', ind2: '1').subfields('a').values.uniq.each do |schul|
      inhalt << 'schulprogramm' if (schul == "Schulprogramm")
    end
    
    source.datafields('652', ind1: 'a', ind2: '1').subfields('a').values.uniq.each do |ress|
      inhalt << 'video' if (ress == "Blu-ray Disc")
      inhalt << 'video' if (ress == "DVD-Video")
      inhalt << 'audio' if (ress == "MP3-CD")
      inhalt << 'audio' if (ress == "MP3-DVD")
      inhalt << 'data_storage' if (ress == "CD-WORM")
      inhalt << 'data_storage' if (ress == "DVD")
    end
    
    inhalt << 'thesis' if source.datafields('673', ind1: 'c').present?
    
    f050  = source.controlfield('050')
    f051  = source.controlfield('051')
    f052  = source.controlfield('052')
    f0501 = f050.values.slice(1) || ""
    f0505 = f050.values.slice(5) || ""
    f0508 = f050.values.slice(8) || ""
    f050a = f050.values.slice(10) || ""
    f051s = f051.values.slice(1..3) || ""
    f052s = f052.values.slice(1) || ""
    f052t = f052.values.slice(2) || ""
    f052u = f052.values.slice(3) || ""
    f052v = f052.values.slice(4) || ""
    f052w = f052.values.slice(5) || ""
    f052x = f052.values.slice(6) || ""
    inhalt << 'handschrift' if f0501.include?('a')
    inhalt << 'video' if f0505.include?('b') || f0505.include?('c')
    inhalt << 'audio' if f0505.include?('a')
    inhalt << 'image' if f0505.include?('d')
    inhalt << 'online_resource' if f0508.include?('g') || f0508.include?('z')
    inhalt << 'data_storage' if f0508.include?('d')
    inhalt << 'map' if f050a.include?('a')
    inhalt << 'bibliography' if f051s.include?('b') || (f052s.include?('b') && f052t.include?('i')) || (f052u.include?('b') && f052v.include?('i')) || (f052w.include?('b') && f052x.include?('i')) 
    inhalt << 'catalog' if f051s.include?('c')
    inhalt << 'dictionary' if f051s.include?('d') || (f052s.include?('w') && f052t.include?('b')) || (f052u.include?('w') && f052v.include?('b')) || (f052w.include?('w') && f052x.include?('b'))  
    inhalt << 'encyclopedia' if f051s.include?('e') || (f052s.include?('e') && f052t.include?('z')) || (f052u.include?('e') && f052v.include?('z')) || (f052w.include?('e') && f052x.include?('z'))
    inhalt << 'festschrift' if f051s.include?('f') || (f052s.include?('f') && f052t.include?('s')) || (f052u.include?('f') && f052v.include?('s')) || (f052w.include?('f') && f052x.include?('s'))
    inhalt << 'database' if f051s.include?('g') || (f052s.include?('d') && f052t.include?('a')) || (f052u.include?('d') && f052v.include?('a')) || (f052w.include?('d') && f052x.include?('a'))
    inhalt << 'biography' if f051s.include?('h') || (f052s.include?('b') && f052t.include?('g')) || (f052u.include?('b') && f052v.include?('g')) || (f052w.include?('b') && f052x.include?('g'))
    inhalt << 'congress' if f051s.include?('k') || (f052s.include?('k') && f052t.include?('o')) || (f052u.include?('k') && f052v.include?('o')) || (f052w.include?('k') && f052x.include?('o'))
    inhalt << 'looseleaf' if f051s.include?('o') || (f052s.include?('l') && f052t.include?('o')) || (f052u.include?('l') && f052v.include?('o')) || (f052w.include?('l') && f052x.include?('o'))
    inhalt << 'statistics' if f051s.include?('s') || (f052s.include?('s') && f052t.include?('t')) || (f052u.include?('s') && f052v.include?('t')) || (f052w.include?('s') && f052x.include?('t'))
    inhalt << 'report' if f051s.include?('r') || (f052s.include?('r') && f052t.include?('e')) || (f052u.include?('r') && f052v.include?('e')) || (f052w.include?('r') && f052x.include?('e'))
    inhalt << 'music' if f051s.include?('m') || (f052s.include?('m') && f052t.include?('u')) || (f052u.include?('m') && f052v.include?('u')) || (f052w.include?('m') && f052x.include?('u'))
    inhalt << 'legaldocument' if f051s.include?('l') || (f052s.include?('a') && f052t.include?('a')) || (f052u.include?('a') && f052v.include?('a')) || (f052w.include?('a') && f052x.include?('a'))|| (f052s.include?('a') && f052t.include?('m')) || (f052u.include?('a') && f052v.include?('m')) || (f052w.include?('a') && f052x.include?('m'))|| (f052s.include?('p') && f052t.include?('a')) || (f052u.include?('p') && f052v.include?('a')) || (f052w.include?('p') && f052x.include?('a'))
    inhalt << 'university_text' if f051s.include?('u')
    inhalt << 'thesis' if f051s.include?('y') || (f052s.include?('w') && f052t.include?('w')) || (f052u.include?('w') && f052v.include?('w')) || (f052w.include?('w') && f052x.include?('w'))
    inhalt << 'lawreport' if (f052s.include?('e') && f052t.include?('s')) || (f052u.include?('e') && f052v.include?('s')) || (f052w.include?('e') && f052x.include?('s'))
    inhalt << 'schulprogramm' if (f052s.include?('s') && f052t.include?('c')) || (f052u.include?('s') && f052v.include?('c')) || (f052w.include?('s') && f052x.include?('c'))
    inhalt << 'website' if (f052s.include?('w') && f052t.include?('s')) || (f052u.include?('w') && f052v.include?('s')) || (f052w.include?('w') && f052x.include?('s'))
    
    
        
        
    inhalt.compact.uniq.presence
  end
    private

  def format
    target.try(:[], "format") || self.class.parent::AddErscheinungsform.new(source: source).call
  end
end
