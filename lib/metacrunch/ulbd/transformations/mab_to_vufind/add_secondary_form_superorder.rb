require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSecondaryFormSuperorder < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "secondary_form_superorder", secondary_form_superorder) : secondary_form_superorder
  end

  private

  def secondary_form_superorder
    secondary_form_superorders = []

    erster_gesamttitel_der_sekundärform_in_vorlageform = source.datafields("621").value
    zweiter_gesamttitel_der_sekundärform_in_vorlageform = source.datafields("627").value

    if erster_gesamttitel_der_sekundärform_in_vorlageform
      identifikationsnummer = source.datafields('623').value
      bandangabe = source.datafields('625').value

      secondary_form_superorders << {
        ht_number: identifikationsnummer,
        label: erster_gesamttitel_der_sekundärform_in_vorlageform,
        volume_count: bandangabe
      }      
    end

    if zweiter_gesamttitel_der_sekundärform_in_vorlageform
      identifikationsnummer = source.datafields('629').value
      bandangabe = source.datafields('631').value

      secondary_form_superorders << {
        ht_number: identifikationsnummer,
        label: zweiter_gesamttitel_der_sekundärform_in_vorlageform,
        volume_count: bandangabe
      }
    end

    source.datafields('649').each do |_datafield|
      if titel = _datafield.subfields("t").value
        identifikationsnummer = _datafield.subfields("9").value
        angaben_zur_reihe = _datafield.subfields("k").values.presence.try(:join, " ")

        secondary_form_superorders <<
        {
          ht_number: (identifikationsnummer if identifikationsnummer.try(:start_with?, "HT")),
          label: titel,
          volume_count: angaben_zur_reihe
        }
      end
    end

    secondary_form_superorders.compact.map(&:to_json).presence  
  end
end
