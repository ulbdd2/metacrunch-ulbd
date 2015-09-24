require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddSecondaryFormPreliminaryPhrase < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "secondary_form_preliminary_phrase", secondary_form_preliminary_phrase) : secondary_form_preliminary_phrase
  end

  private

  def secondary_form_preliminary_phrase
    preliminary_phrases = []

    # Fußnote(n) zur Sekundärausgabe
    source.datafields('610').each do |_datafield|
      if value = _datafield.subfields("a").value
        if _datafield.ind1 == "-"
          einleitende_wendung = value
        end

        preliminary_phrases << einleitende_wendung
      end
    end

    # Vermerk und Link für andere Ausgaben (RDA)
    source.datafields('649').each do |_datafield|
      ausgabevermerk = _datafield.subfields("b").value
      preliminary_phrases << ausgabevermerk
    end

    # cleanup
    preliminary_phrases.compact.uniq.presence
  end
end
