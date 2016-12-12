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
    f052s = f052.values.join.slice(1..2) || ""
    f052t = f052.values.join.slice(3..4) || ""
    f052u = f052.values.join.slice(5..6) || ""
    inhalt << 'handschrift' if f0501.include?('a')
    inhalt << 'video' if f0505.include?('b') || f0505.include?('c')
    inhalt << 'audio' if f0505.include?('a')
    inhalt << 'image' if f0505.include?('d')
    inhalt << 'online_resource' if f0508.include?('g') || f0508.include?('z')
    inhalt << 'data_storage' if f0508.include?('d')
    inhalt << 'map' if f050a.include?('a')
    inhalt << 'bibliography' if f051s.include?('b') || f052s.include?('bi') || f052t.include?('bi') || f052u.include?('bi')
    inhalt << 'catalog' if f051s.include?('c')
    inhalt << 'dictionary' if f051s.include?('d') || f052s.include?('wb') || f052t.include?('wb') || f052u.include?('wb')  
    inhalt << 'encyclopedia' if f051s.include?('e') || f052s.include?('ez') || f052t.include?('ez') || f052u.include?('ez')
    inhalt << 'festschrift' if f051s.include?('f') || f052s.include?('fs') || f052t.include?('fs') || f052u.include?('fs')
    inhalt << 'database' if f051s.include?('g') || f052s.include?('da') || f052t.include?('da') || f052u.include?('da')
    inhalt << 'biography' if f051s.include?('h') || f052s.include?('bg') || f052t.include?('bg') || f052u.include?('bg')
    inhalt << 'congress' if f051s.include?('k') || f052s.include?('ko') || f052t.include?('ko') || f052u.include?('ko')
    inhalt << 'looseleaf' if f051s.include?('o') || f052s.include?('lo') || f052t.include?('lo') || f052u.include?('lo')
    inhalt << 'statistics' if f051s.include?('s') || f052s.include?('st') || f052t.include?('st') || f052u.include?('st')
    inhalt << 'report' if f051s.include?('r') || f052s.include?('re') || f052t.include?('re') || f052u.include?('re')
    inhalt << 'music' if f051s.include?('m') || f052s.include?('mu') || f052t.include?('mu') || f052u.include?('mu')
    inhalt << 'legaldocument' if f051s.include?('l') || f052s.include?('aa') || f052t.include?('am') || f052u.include?('pa')
    inhalt << 'university_text' if f051s.include?('u')
    inhalt << 'thesis' if f051s.include?('y') || f052s.include?('ww') || f052t.include?('ww') || f052u.include?('ww')
    inhalt << 'lawreport' if f052s.include?('es') || f052t.include?('es') || f052u.include?('es')
    inhalt << 'schulprogramm' if f052s.include?('sc') || f052t.include?('sc') || f052u.include?('sc')
    inhalt << 'website' if f052s.include?('ws') || f052t.include?('ws') || f052u.include?('ws')
    
    
        
        
    inhalt.compact.uniq.presence
  end
    private

  def format
    target.try(:[], "format") || self.class.parent::AddErscheinungsform.new(source: source).call
  end
end
