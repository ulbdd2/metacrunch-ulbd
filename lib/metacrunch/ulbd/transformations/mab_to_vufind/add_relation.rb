require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddRelation < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "relation_txt_mv", relation) : relation
  end

  private

  def relation
    relations = []

    # Identifikationsnummer der Primärform
    source.datafields('021').each do |_datafield|
      if identifikationsnummer = _datafield.subfields("a").value
        is_regionale_identifikationsnummer = _datafield.ind1 == "b"
        is_unbekannte_identifikationsnummer = _datafield.ind1 == "-"

        if is_regionale_identifikationsnummer || is_unbekannte_identifikationsnummer
          relations << {
            ht_number: identifikationsnummer,
            label: 'Primärform'
          }
        end
      end
    end

    # Identifikationsnummer der Sekundärform
    source.datafields('022').each do |_datafield|
      if identifikationsnummer = _datafield.subfields("a").value
        is_regionale_identifikationsnummer = _datafield.ind1 == "b"
        is_unbekannte_identifikationsnummer = _datafield.ind1 == "-"

        if is_regionale_identifikationsnummer || is_unbekannte_identifikationsnummer
          relations << {
            ht_number: identifikationsnummer,
            label: 'Sekundärform'
          }
        end
      end
    end

    [
      "Titel von rezensierten Werken",
      "andere Ausgaben",
      "Titel von Rezensionen",
      "Beilagen",
      "übergeordnete Einheiten der Beilage",
      "Vorgänger",
      "Nachfolger",
      "sonstige Beziehungen",
      "andere Ausgaben identisch neu",
      "andere Ausgaben unterschied neu",
      "Beilagen neu",
      "übergeordnete Einheiten der Beilage neu",
      "Erschienen mit",
      "Vorgänger neu",
      "Nachfolger neu",
      "sonstige Beziehungen neu"
    ]
    .each do |property|
      source.get(property).each do |element|
        relations << relation_factory(element.get, element.get("Identifikationsnummer"))
      end
    end

    relations.flatten.select { |relation| relation[:label].present? }.map(&:to_json)
  end

  def relation_factory(label, id)
    {
      ht_number: id,
      label: label
    }
    .compact
  end
end