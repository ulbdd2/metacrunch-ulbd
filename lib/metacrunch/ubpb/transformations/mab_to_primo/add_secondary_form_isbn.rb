require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddSecondaryFormIsbn < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "secondary_form_isbn", secondary_form_isbn) : secondary_form_isbn
  end

  private

  def secondary_form_isbn
    isbns = []

    # ISBN(s) der Sekundärformen
    source.datafields('634').each do |_datafield|
      if value = _datafield.subfields("a").value
        if _datafield.ind1 == "-"
          isbn_formal_nicht_geprüft = value
        elsif _datafield.ind1 == "a"
          isbn_formal_richtig = value
        elsif _datafield.ind1 == "b"
          isbn_formal_falsch = value
        end

        isbns << isbn_formal_richtig || isbn_formal_nicht_geprüft || isbn_formal_falsch
      end
    end

    # Vermerk und Link für andere Ausgaben (RDA)
    source.datafields('649').each do |_datafield|
      isbn = _datafield.subfields("z").value
      isbns << isbn
    end

    # cleanup
    isbns.compact.uniq.presence
  end
end
