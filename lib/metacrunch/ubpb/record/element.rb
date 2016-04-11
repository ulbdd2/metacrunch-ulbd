require_relative "../record"

class Metacrunch::UBPB::Record::Element
  SUBFIELDS = {
    a: { "nicht spezifiziert" => :NW }
  }

  attr_accessor :properties

  def initialize(datafield, options = {})
    @tag = datafield.tag
    @ind1 = datafield.ind1
    @ind2 = datafield.ind2
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

    # this should be merged with the code above
    self.class::SUBFIELDS.each do |_, mapping|
      mapping.each do |property_name, cardinality|
        @properties[property_name] ||= (cardinality.to_s.downcase == "w" ? [] : nil)
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
    if @ind2 == "2"
      if include_options = options[:include]
        include_options = [include_options].flatten(1).compact

        if include_options.include?("Überordnungen")
          true
        else
          false
        end
      else
        false
      end
    else
      true
    end
  end

  private

  def default_value(options = {})
    @properties.values.first
  end
end
