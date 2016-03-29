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
    if property.is_a?(Hash)
      options = property
      property = nil
    end

    omit_options = [options[:omit]].flatten(1).compact

    value = (property ? @properties[property] : default_value(options))
    return unless value

    if omit_options.include?("sortierirrelevante Worte")
      regex = /<<[^>]+>>/

      if value.is_a?(Array)
        value.map do |element|
          element.gsub(regex, "").strip
        end
      else
        value.gsub(regex, "").strip
      end
    else
      if value.is_a?(Array)
        value.map do |element|
          element.gsub(/<<|>>/, "")
        end
      else
        value.gsub(/<<|>>/, "")
      end
    end
  end

  def selected?(options = {})
    true
  end

  private

  def default_value(options = {})
    @properties.values.first
  end
end
