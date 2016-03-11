require_relative "../mab_to_primo"
require_relative "./entität"

class Metacrunch::UBPB::Transformations::MabToPrimo::Körperschaft < Metacrunch::UBPB::Transformations::MabToPrimo::Entität
  subfields do
    {
      a: {
        "Körperschaft (unstrukturiert)" => :NW,
        "Konferenz (unstrukturiert)" => :NW,
        "Gebietskörperschaft (unstrukturiert)" => :NW
      },
      k: { "Körperschaft (strukturiert)" => :NW },
      e: { "Konferenz (strukturiert)" => :NW },
      g: { "Gebietsköperschaft (strukturiert)" => :NW },
      b: { "untergeorgnete Körperschaft" => :W },
      n: { "Zählung" => :W },
      h: { "Zusatz" => :W },
      c: { "Ort der Konferenz" => :W },
      d: { "Datum der Konferenz" => :NW },
      x: { "allgemeine Unterteilung" => :W },
      z: { "geografische Unterteilung" => :W },
      "4": { "Beziehungscode" => :W },
      "9": { "GND Identifikationsnummer" => :NW },
      "3": { "Beziehungskennzeichnung in deutscher Sprache" => :W }, # wird nicht aktiv erfasst
      "5": { "Beziehungskennzeichnung in einer anderen Katalogisierungssprache" => :W } # wird nicht aktiv erfasst
    }
  end

  # @param [Document] document
  # @param [Hash] options
  # @option options [Boolean] :include_superorders (true) Wether to include corporate bodies from superorders
  #
  # @return [Array<Körperschaft>]
  def self.factory(document, options = {})
    options[:include_superorders] = true if options[:include_superorders].nil?
    ind2 = options[:include_superorders] ? ["1", "2"] : ["1"]

    (200..296).step(4).each_with_object([]) do |tag, result|
      document.datafields("#{tag}", ind2: ['1', '2']).each do |datafield|
        result.push new(datafield)
      end
    end
    .tap do |r|
      binding.pry
    end
  end
end
