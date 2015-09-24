require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddSecondaryFormPublisher < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "secondary_form_publisher", secondary_form_publisher) : secondary_form_publisher
  end

  private

  def secondary_form_publisher
    secondary_form_publishers = []

    # Name des 1. Verlegers, Herstellers usw.
    source.datafields('613').each.with_index do |_datafield, _index|
      if value = _datafield.subfields("a").value
        erster_verleger = value
        ort_des_ersten_verlegers = source.datafields('611').subfields.values[_index]

        secondary_form_publishers << [ort_des_ersten_verlegers, erster_verleger].compact.join(" : ")
      end
    end

    # Vermerk und Link für andere Ausgaben (RDA)
    source.datafields('649').each do |_datafield|
      # Wenn es sich um einens Erscheingunsvermerk handelt müssen wir das anhegängte Datum entfernen
      erscheinungsort_oder_erscheinungsvermerk = _datafield.subfields("d").value

      if erscheinungsort_oder_erscheinungsvermerk[/,.+\Z/]
        erscheinungsvermerk = erscheinungsort_oder_erscheinungsvermerk
      else
        erscheinungsort = erscheinungsort_oder_erscheinungsvermerk
      end

      verleger = _datafield.subfields("e").value

      secondary_form_publishers <<
      if verleger
        [erscheinungsort, verleger].compact.join(" : ")
      else
        # Wenn der Erscheinungsvermerk herangezogen wird muss das angehängte Datum entfernt werden
        erscheinungsvermerk.try(:gsub, /,.+\Z/, "")
      end
    end

    # cleanup
    secondary_form_publishers.compact.uniq.presence
  end
end
