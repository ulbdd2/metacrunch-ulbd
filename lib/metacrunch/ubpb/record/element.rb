require_relative "../record"

class Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    a: { "nicht spezifiziert" => :NW }
  }

  attr_accessor :properties

  def initialize(datafield, options = {})
    @properties = {}

    datafield.subfields.each do |subfield|
      if mapping = self.class::SUBFIELDS[subfield.code.to_sym]
        mapping.each do |property_name, cardinality|
          if cardinality.to_s.downcase == "nw"
            @properties[property_name] = subfield.value
          else
            (@properties[property_name] ||= []).push subfield.value
          end
        end
      end
    end
  end

  def get(property = nil, options = {})
    unless property
      @properties.values.first
    else
      @properties[property]
    end
  end
end
