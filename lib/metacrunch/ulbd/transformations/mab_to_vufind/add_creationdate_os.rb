require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./helpers/is_superorder"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreationdateOs < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::IsSuperorder

  def call
        target ? Metacrunch::Hash.add(target, "publishDate_os", creationdate_os) : creationdate_os
  end

  private

  def creationdate_os
    erscheinungsjahr_in_vorlageform     = source.datafields('D25', ind1: '-', ind2: '1').subfields('a').value
    erscheinungsjahr_in_vorlageform_rda = source.datafields('D19', ind1: '-', ind2: '1').subfields('c').value     
    erscheinungsjahr_in_ansetzungsform  = source.datafields('D25', ind1: 'a', ind2: '1').subfields('a').value
    erscheinungsjahr_des_ersten_bandes  = source.datafields('D25', ind1: 'b', ind2: '1').subfields('a').value
    erscheinungsjahr_des_letzten_bandes = source.datafields('D25', ind1: 'c', ind2: '1').subfields('a').value
    publikationsdatum_bei_tonträgern    = source.datafields('D25', ind1: 'p', ind2: '1').subfields('a').value
    erscheinungsjahr_der_quelle         = source.datafields('E95').value

    if erscheinungsjahr_der_quelle
      erscheinungsjahr_der_quelle # hat Vorrang vor dem eigentlichen Erscheinungsjahr
    elsif is_superorder?(source) && (erscheinungsjahr_des_ersten_bandes || erscheinungsjahr_des_letzten_bandes)
      [
        erscheinungsjahr_des_ersten_bandes,
        erscheinungsjahr_des_letzten_bandes
      ]
      .uniq.join(" - ").strip # returns either "xxxx -", "xxxx - yyyy" or "- yyyy"
    else
      erscheinungsjahr_in_vorlageform || erscheinungsjahr_in_vorlageform_rda || erscheinungsjahr_in_ansetzungsform || publikationsdatum_bei_tonträgern
    end
  end
end
