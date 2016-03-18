require_relative "../ubpb"

class Metacrunch::UBPB::Record
  require_relative "./record/collection"
  require_relative "./record/element"

  Dir.glob(File.join([File.dirname(__FILE__), "record", "collection", "*.rb"])).each do |filename|
    require_relative filename.sub(File.dirname(__FILE__) + "/", "./").sub(/.rb\Z/, "")
  end

  Dir.glob(File.join([File.dirname(__FILE__), "record", "element", "*.rb"])).each do |filename|
    require_relative filename.sub(File.dirname(__FILE__) + "/", "./").sub(/.rb\Z/, "")
  end

  PROPERTIES = {
    "Arten des Inhalts" =>              { tag:  "064", ind1: "a",   element: Element::ArtDesInhalts },
    "erweiterte Datenträgertypen" =>    { tag:  "064", ind1: "b",   element: Element::ErweiterterDatenträgertyp },
    "Personen" =>                       { tags: (100..196).step(4), element: Element::Person },
    "Körperschaften" =>                 { tags: (200..296).step(4), element: Element::Körperschaft },
    "bevorzugte Titel des Werkes" =>    { tag:  "303",              element: Element::Titel },
    "allgemeine Materialbenennung" =>   { tag:  "334",              is_collection: false },
    "Verantwortlichkeitsangaben" =>     { tag:  "359" },
    "Unaufgegliederte Anmerkungen" =>   { tag:  "501" },
    "Personen der Nebeneintragungen" => { tags: (800..824).step(6), element: Element::Person },
    "Körperschaften Phrasenindex" =>    { tag:  "PKO",              element: Element::Körperschaft },
    "Personen Phrasenindex" =>          { tag:  "PPE",              element: Element::Person }
  }

  delegate :controlfield, :datafields, to: :@document

  def initialize(document)
    @document = document
  end

  def get(property, options = {})
    if value = PROPERTIES[property]
      collection_class = collection_defined?(property) ? collection_get(property) : Collection
      tags = value[:tag] ? [value[:tag]] : value[:tags].to_a
      ind1 = options[:ind1] || value[:ind1]
      ind2 = options[:ind2] || ([options[:include]].flatten(1).compact.include?("Überordnungen") ? ["1", "2"] : "1")
      element_class = value[:element] || Element

      datafields =
      tags.map do |tag|
        @document.datafields("#{tag}", ind1: ind1, ind2: ind2).to_a.presence
      end
      .flatten
      .compact

      if value[:is_collection] == false
        element_class.new(datafields.first, options)
      else
        collection_class.new(datafields, options.reverse_merge(element_class: element_class))
      end
    end
  end

  private

  def collection_defined?(name)
    self.class::Collection.const_defined? derived_constant_name(name)
  end

  def collection_get(name)
    self.class::Collection.const_get derived_constant_name(name)
  end

  def derived_constant_name(name)
    name.squish.split.map(&:titlecase).join
  end
end
