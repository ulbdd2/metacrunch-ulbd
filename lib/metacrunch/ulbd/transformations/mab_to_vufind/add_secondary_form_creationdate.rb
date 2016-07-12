require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSecondaryFormCreationdate < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "secondary_form_creationdate", secondary_form_creationdate) : secondary_form_creationdate
  end

  private

  def secondary_form_creationdate
    creationdates = []

    # Erscheinungsjahr(e) der Sekundärform
    source.datafields('619').each do |_datafield|
      erscheinungsjahr_in_ansetzungsform = _datafield.subfields("a").value
      erscheinungsjahr_des_ersten_bandes_in_ansetzungsform = _datafield.subfields("b").value
      erscheinungsjahr_des_letzten_bandes_in_ansetzungsform = _datafield.subfields("c").value

      creationdates <<
      erscheinungsjahr_in_ansetzungsform ||
      erscheinungsjahr_des_ersten_bandes_in_ansetzungsform ||
      erscheinungsjahr_des_letzten_bandes_in_ansetzungsform
    end

    # Vermerk und Link für andere Ausgaben (RDA)
    source.datafields('649').each do |_datafield|
      erscheinungsjahr = _datafield.subfields("f").value

      creationdates << erscheinungsjahr
    end

    # cleanup
    creationdates.compact.uniq.presence
  end
end
