require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddFremddigi < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "fremddigi_txt_mv", fremd) : fremd
  end

  private

  def fremd
    toc_links = []

    source.datafields('655').each do |datafield|
      url        = datafield.subfields('u').value
      subfield_3 = datafield.subfields('3').value
      
      if (url.present? && subfield_3.present? && subfield_3 =~ /^digitali/i)
         toc_links << subfield_3
      end
    end

    toc_links.compact.presence
  end
end
