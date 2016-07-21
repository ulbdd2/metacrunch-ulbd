require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSecondaryFormPhysicalDescription < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "secondary_form_physical_description_str_mv", secondary_form_physical_description) : secondary_form_physical_description
  end

  private

  def secondary_form_physical_description
    physical_descriptions = []

    # Umfangsangabe(n) und physische Beschreibung(en) der Sekundärform
    source.datafields('637').each do |_datafield|
      if value = _datafield.subfields("a").value
        if _datafield.ind1 == "-"
          umfangsangabe_und_physische_beschreibung = value
        end

        physical_descriptions << umfangsangabe_und_physische_beschreibung
      end
    end

    # Vermerk und Link für andere Ausgaben (RDA)
    source.datafields('649').each do |_datafield|
      physische_beschreibung = _datafield.subfields("h").value
      physical_descriptions << physische_beschreibung
    end

    # cleanup
    physical_descriptions.compact.uniq.presence
  end
end
