require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_title"
require_relative "./add_title_os"

class Metacrunch::ULBD::Transformations::MabToVufind::AddTitleSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "title_search_txt_mv", title_search) : title_search
  end

  private

  def title_search
    search_titles = []
    search_titles << title_display
    search_titles << title_display_os

    search_titles << source.datafields('304', ind2: '1').subfields('a').values
            
    (340..355).each do |f|
      search_titles << source.datafields("#{f}", ind2: '1').subfields('a').values
    end

    search_titles << source.datafields('370', ind2: '1').subfields('a').values

    search_titles << source.datafields('376', ind2: '1').subfields('a').values
    (451..491).step(10).each do |f|
      search_titles << source.datafields("#{f}", ind2: '1').subfields('a').values
    end
    search_titles << source.datafields('502', ind2: '1').subfields('a').values
    search_titles << source.datafields('504', ind2: '1').subfields('a').values
    search_titles << source.datafields('505', ind2: '1').subfields('a').values
    (526..534).each do |f|
      search_titles << source.datafields("#{f}", ind2: '1').subfields('a').values
    end
    search_titles << source.datafields('621', ind2: '1').subfields('a').values
    search_titles << source.datafields('627', ind2: '1').subfields('a').values
    search_titles << source.datafields('633', ind2: '1').subfields('a').values
    search_titles << source.datafields('670', ind2: '1').subfields('a').values
    search_titles << source.datafields('675', ind2: '1').subfields('a').values

    # frühere Titel (RDA)
    source.datafields('375', ind2: [:blank, '1']).each do |_datafield|
      _früherer_titel = _datafield.subfields('a').value
      search_titles << _früherer_titel
    end

    source.get("Angaben zum Inhalt").each do |element|
      search_titles << element.get("Titel")
    end

    source.get("bevorzugte Titel des Werkes").each do |element|
      search_titles << element.get("Titel")
    end

    source.get("in Beziehung stehende Werke").each do |element|
      search_titles << element.get("Titel")
    end

    source.get("Manifestationstitel von weiteren verkörperten Werken").each do |element|
      search_titles << element.get("Titel")
    end
    
    source.get("Titel der Nebeneintragungen").each do |element|
    search_titles << element.get("Titel")
    end
    
    source.get("EST der Nebeneintragungen").each do |element|
      search_titles << element.get("Titel")
    end
    
    source.get("Angaben zum Inhalt Os").each do |element|
    search_titles << element.get("Titel")
    end
    
    source.get("bevorzugte Titel des Werkes Os").each do |element|
    search_titles << element.get("Titel")
    end
    
    source.get("in Beziehung stehende Werke Os").each do |element|
    search_titles << element.get("Titel")
    end
    
    source.get("Manifestationstitel von weiteren verkörperten Werken Os").each do |element|
    search_titles << element.get("Titel")
    end
    
    source.get("Titel der Nebeneintragungen Os").each do |element|
    search_titles << element.get("Titel")
    end
  
    source.get("EST der Nebeneintragungen Os").each do |element|
      search_titles << element.get("Titel")
    end
    
    search_titles << source.datafields('C04', ind2: '1').subfields('a').values
    search_titles << source.datafields('C40', ind2: '1').subfields('a').values
    search_titles << source.datafields('C41', ind2: '1').subfields('a').values
    search_titles << source.datafields('C43', ind2: '1').subfields('a').values
    search_titles << source.datafields('C44', ind2: '1').subfields('a').values
    search_titles << source.datafields('C45', ind2: '1').subfields('a').values
    search_titles << source.datafields('C47', ind2: '1').subfields('a').values
    search_titles << source.datafields('C48', ind2: '1').subfields('a').values
    search_titles << source.datafields('C49', ind2: '1').subfields('a').values
    search_titles << source.datafields('C51', ind2: '1').subfields('a').values
    search_titles << source.datafields('C52', ind2: '1').subfields('a').values
    search_titles << source.datafields('C53', ind2: '1').subfields('a').values
    search_titles << source.datafields('C55', ind2: '1').subfields('a').values
    search_titles << source.datafields('C70', ind2: '1').subfields('a').values
    search_titles << source.datafields('C76', ind2: '1').subfields('a').values
    search_titles << source.datafields('D51', ind2: '1').subfields('a').values
    search_titles << source.datafields('D61', ind2: '1').subfields('a').values
    search_titles << source.datafields('D71', ind2: '1').subfields('a').values
    search_titles << source.datafields('D81', ind2: '1').subfields('a').values
    search_titles << source.datafields('D91', ind2: '1').subfields('a').values
    search_titles << source.datafields('E02', ind2: '1').subfields('a').values
    search_titles << source.datafields('E04', ind2: '1').subfields('a').values
    search_titles << source.datafields('E05', ind2: '1').subfields('a').values
    search_titles << source.datafields('E27', ind2: '1').subfields('a').values
    search_titles << source.datafields('E31', ind2: '1').subfields('a').values
    search_titles << source.datafields('E33', ind2: '1').subfields('a').values
    search_titles << source.datafields('F70', ind2: '1').subfields('a').values
    search_titles << source.datafields('F75', ind2: '1').subfields('a').values
    
    source.datafields('C75', ind2: [:blank, '1']).each do |_datafield|
      _früherer_titel = _datafield.subfields('a').value
      search_titles << _früherer_titel
    end  
    
    search_titles
    .flatten
    .compact
    .map do |search_title|
      # add entries without dashes in words, if words with dashes are present
      if search_title.match(/[A-ZÄÖÜ][a-zäöü]+\-[A-ZÄÖÜ][a-zäöü]+/)
        [search_title, search_title.split(' ').map { |string| string.gsub(/([A-ZÄÖÜ][a-zäöü]+)\-([A-ZÄÖÜ][a-zäöü]+)/, '\1\2').downcase.capitalize }.join(' ')]
      else
        search_title
      end
    end
    .flatten
    .map(&:presence)
    .compact
    .map do |_title_search|
#      _title_search.gsub(/\[.+\]/, "").strip
       _title_search.gsub(/<<|>>/, "")
    end
    .compact
    .uniq
  end
  

  private

  def title_display
    target.try(:[], "title_display") || self.class.parent::AddTitleDisplay.new(source: source).call
  end
  def title_display_os
    target.try(:[], "title_display_os") || self.class.parent::AddTitleOs.new(source: source).call
  end
end