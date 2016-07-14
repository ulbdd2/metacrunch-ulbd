require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./helpers/is_superorder"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreationdate < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::IsSuperorder

  def call
    target ? Metacrunch::Hash.add(target, "publishDate", creationdate) : creationdate
  end

  private

  def creationdate
    erscheinungsjahr_in_ansetzungsform  = source.datafields('425', ind1: 'a', ind2: '1').subfields('a').value
    erscheinungsjahr_des_ersten_bandes  = source.datafields('425', ind1: 'b', ind2: '1').subfields('a').value
    erscheinungsjahr_des_letzten_bandes = source.datafields('425', ind1: 'c', ind2: '1').subfields('a').value
    publikationsdatum_bei_tonträgern    = source.datafields('425', ind1: 'p', ind2: '1').subfields('a').value
    erscheinungsjahr_der_quelle         = source.datafields('595').value

    if erscheinungsjahr_der_quelle
      erscheinungsjahr_der_quelle # hat Vorrang vor dem eigentlichen Erscheinungsjahr
    elsif is_superorder?(source) && (erscheinungsjahr_des_ersten_bandes || erscheinungsjahr_des_letzten_bandes)
      [
        erscheinungsjahr_des_ersten_bandes,
        erscheinungsjahr_des_letzten_bandes
      ]
      .uniq.join(" - ").strip # returns either "xxxx -", "xxxx - yyyy" or "- yyyy"
    else
      erscheinungsjahr_in_ansetzungsform || publikationsdatum_bei_tonträgern
    end
  end
end
