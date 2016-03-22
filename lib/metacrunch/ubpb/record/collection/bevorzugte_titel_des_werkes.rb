require_relative "../collection"

class Metacrunch::UBPB::Record::Collection::BevorzugteTitelDesWerkes < Metacrunch::UBPB::Record::Collection
  def initialize(datafields, options = {})
    include_options_values = [options[:include]].compact.flatten(1)
    ind1 = ["-"]

    if include_options_values.include?("in der Manifestation verkörperte Werke") || include_options_values.include?("in Beziehung stehende Werke")
      ind1 << "t"
    end

    super(datafields, options.merge(ind1: ind1))
  end
end
