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
    "Bevorzugte Titel des Werkes" =>    { tag:  "303",              element: Element::Titel },
    "Körperschaften" =>                 { tags: (200..296).step(4), element: Element::Körperschaft },
    "Körperschaften Phrasenindex" =>    { tag:  "PKO",              element: Element::Körperschaft },
    "Personen" =>                       { tags: (100..196).step(4), element: Element::Person }, 
    "Personen der Nebeneintragungen" => { tags: (800..824).step(6), element: Element::Person },
    "Personen Phrasenindex" =>          { tag:  "PPE",              element: Element::Person },
    "Unaufgegliederte Anmerkungen" =>   { tag:  "501" },
    "Verantwortlichkeitsangaben" =>     { tag:  "359" }
  }

  delegate :controlfield, :datafields, to: :@document

  def initialize(document)
    @document = document
  end

  def get(property, options = {})
    if value = PROPERTIES[property]
      collection_class = collection_defined?(property) ? collection_get(property) : Collection
      tags = value[:tag] ? [value[:tag]] : value[:tags].to_a
      element_class = value[:element] || Element

      collection_class.new(@document, tags, element_class, options)
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
