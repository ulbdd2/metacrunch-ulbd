require_relative "../record"

class Metacrunch::UBPB::Record::GenericControlfield
  POSITIONS = {
    0..14 => { "nicht spezifiziert" => {} }
  }

  attr_accessor :properties

  def initialize(controlfield, options = {})
    @tag = controlfield.tag
    @properties = {}

    self.class::POSITIONS.each do |position, description|
      property_name = description.keys.first.to_s
      indices = position.is_a?(Range) ? position.to_a : [position]
      value_to_lookup = indices.map { |index| controlfield.at(index) }.join
      @properties[property_name] = description.values.first.find { |key, _| key.to_s == value_to_lookup }.try(:last)
    end
  end

  def get(property, options = {})
    if property.is_a?(Hash)
      options = property
      property = nil
    end

    property ? @properties[property] : default_value(options)
  end

  def selected?(options)
    true
  end

=begin
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
=end
end
