require_relative "../collection"
require_relative "../element/titel"

class Metacrunch::UBPB::Record::Collection::BevorzugteTitelDesWerkes < Metacrunch::UBPB::Record::Collection
  def initialize(document, tags, element_class, options = {})
    options[:include] = [options[:include]].compact.flatten(1)
    ind1 = ["-"]

    if options[:include].include?("in der Manifestation verkörperte Werke") || options[:include].include?("in Beziehung stehende Werke")
      ind1 << "t"
    end

    super(document, tags, element_class, options.merge(ind1: ind1))
  end
end
