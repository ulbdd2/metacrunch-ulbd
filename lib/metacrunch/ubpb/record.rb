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
    "Arten des Inhalts" =>                                    { tag:  "064", ind1: "a",   element: Element::ArtDesInhalts },
    "erweiterte Datenträgertypen" =>                          { tag:  "064", ind1: "b",   element: Element::ErweiterterDatenträgertyp },
    "Personen" =>                                             { tags: (100..196).step(4), element: Element::Person },
    "Körperschaften" =>                                       { tags: (200..296).step(4), element: Element::Körperschaft },
    "bevorzugte Titel des Werkes" =>                          { tag:  "303",              element: Element::BevorzugterTitelDesWerkes },
    "allgemeine Materialbenennung" =>                         { tag:  "334",              is_collection: false },
    "Verantwortlichkeitsangaben" =>                           { tag:  "359" },
    "Manifestationstitel von weiteren verkörperten Werken" => { tag:  "362",              element: Element::ManifestationstitelVonWeiterenVerkörpertenWerken },
    "Unaufgegliederte Anmerkungen" =>                         { tag:  "501" },
    "Angaben zum Inhalt" =>                                   { tag:  "521",              element: Element::AngabeZumInhalt },
    "Titel von rezensierten Werken" =>                        { tag:  "526",              element: Element::TitelVonRezensiertemWerk },
    "andere Ausgaben" =>                                      { tag:  "527",              element: Element::AndereAusgabe },
    "Titel von Rezensionen" =>                                { tag:  "528",              element: Element::TitelVonRezension },
    "Beilagen" =>                                             { tag:  "529",              element: Element::Beilage },
    #"übergeordnete Einheiten der Beilage" =>                  { tag:  "530",              element: Element::ÜbergeordneteEinheitDerBeilage },
    #"Vorgänger" =>                                            { tag:  "531",              element: Element::Vorgänger },
    #"Nachfolger" =>                                           { tag:  "533",              element: Element::Nachfolger },
    #"sonstige Beziehungen" =>                                 { tag:  "534",              element: Element::SonstigeBeziehung },
    "ISBNs" =>                                                { tag:  "540",              element: Element::ISBN },
    "Personen der Nebeneintragungen" =>                       { tags: (800..824).step(6), element: Element::Person },
    "Körperschaften Phrasenindex" =>                          { tag:  "PKO",              element: Element::Körperschaft },
    "Personen Phrasenindex" =>                                { tag:  "PPE",              element: Element::Person }
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
    name.squish.split.map { |string| string[0].upcase + string[1..-1] }.join
  end
end
