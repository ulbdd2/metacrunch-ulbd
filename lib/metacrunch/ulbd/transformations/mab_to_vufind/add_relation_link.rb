require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddRelationLink < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "relation_link_txt_mv", relationlink) : relationlink
  end

  private

  def relationlink
    
    relationlink = []

    source.datafields('PLK').each do |datafield|
           typ        = datafield.subfields('a').value
           sys        = datafield.subfields('b').value
           label      = datafield.subfields('n').value
        #fulltext_links << url       
        #fulltext_links << label
         
    relationlink << {
            typ: typ,
            sys_no: sys,
            label: label
         } 
      end
    
    
    relationlink.flatten.select { |relationlink| relationlink[:label].present? }.map(&:to_json)
  end
end



