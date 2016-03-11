require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::Entität
  def self.subfields(&block)
    subfield_mapping = yield

    define_method :initialize do |datafield|
      @properties = {}

      datafield.subfields.each do |subfield|
        if mapping = subfield_mapping[subfield.code.to_sym]
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
  end

  def [](property_name)
    (@properties || {})[property_name]
  end
end
