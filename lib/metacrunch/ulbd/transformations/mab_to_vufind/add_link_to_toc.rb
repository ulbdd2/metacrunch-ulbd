require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddLinkToToc < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "link_to_toc", link_to_toc) : link_to_toc
  end

  private

  def link_to_toc
    toc_links = []

    source.datafields('655').each do |datafield|
      url        = datafield.subfields(['u','y']).values
      subfield_u = datafield.subfields('u').value
      subfield_y = datafield.subfields('y') # HBZ Inhaltsverzeichnisse
      subfield_z = datafield.subfields('z') # BVB Inhaltsverzeichnisse
      subfield_t = datafield.subfields('t') # Type: VIEW => Adam Inhaltsverzeichnis

      if (url.present? && subfield_y.present? && subfield_y.value =~ /^inhaltsv/i) ||
          (url.present? && subfield_y.present? && subfield_y.value =~ /^vorwort/i) ||
          (url.present? && subfield_y.present? && subfield_y.value =~ /^kapitel/i) ||
          (url.present? && subfield_y.present? && subfield_y.value =~ /^buchumschlag/i) ||
         (url.present? && subfield_z.present? && subfield_z.value =~ /^inhaltsv/i) 
        toc_links << url
        elsif
        (subfield_u.present? && subfield_t.present? && subfield_t.value =~ /^view/i)
        toc_links << subfield_u
      end
    end

    toc_links.compact.presence
    
    end
end
