require_relative "../record"

class Metacrunch::UBPB::Record::Element
  SUBFIELD_MAPPING = {}

  attr_accessor :properties

  def initialize(datafield, options = {})
    @properties = {}

    datafield.subfields.each do |subfield|
      if mapping = self.class::SUBFIELD_MAPPING[subfield.code.to_sym]
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

  def get(property = nil)
    unless property
      @properties.values.first
    else
      @properties[property]
    end
  end
end
