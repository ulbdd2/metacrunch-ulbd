require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddResourceLink < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "resource_link_txt_mv", resource_link) : resource_link
  end

  private

  def resource_link
    fulltext_links = []

    source.datafields('655', ind2: "9").each do |datafield|
           url        = datafield.subfields('u').value
        fulltext_links << url       
    end
    
    source.datafields('655', ind2: "1").each do |datafield|
      url        = datafield.subfields('u').value
      subfield_3 = datafield.subfields('3') # HBZ Inhaltsverzeichnisse
      subfield_z = datafield.subfields('z') # BVB Inhaltsverzeichnisse
      subfield_t = datafield.subfields('t') # Type: VIEW => Adam Inhaltsverzeichnis

      unless (url.present? && subfield_3.present? && subfield_3.value =~ /^inhalt/i) ||
             (url.present? && subfield_z.present? && subfield_z.value =~ /^inhalt/i) ||
             (url.present? && subfield_t.present? && subfield_t.value =~ /^view/i)
        fulltext_links << url
      end
    end

    fulltext_links.compact.presence
  end
end
