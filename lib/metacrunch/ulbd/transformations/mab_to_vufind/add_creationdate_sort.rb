require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
#require_relative "./helpers/is_superorder"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreationdateSort < Metacrunch::Transformator::Transformation::Step
#  include parent::Helpers::IsSuperorder

  def call
    #target ? Metacrunch::Hash.add(target, "creationdate", creationdate) : creationdate
    target ? Metacrunch::Hash.add(target, "publishDateSort", creationdatesort) : creationdatesort
  end

  private

  def creationdatesort
    #erscheinungsjahr_in_vorlageform     = source.datafields('425', ind1: '-', ind2: '1').subfields('a').value
    #erscheinungsjahr_in_vorlageform_rda = source.datafields('419', ind1: '-', ind2: '1').subfields('c').value     
    erscheinungsjahr_in_ansetzungsform  = source.datafields('425', ind1: 'a', ind2: '1').subfields('a').value
    erscheinungsjahr_des_ersten_bandes  = source.datafields('425', ind1: 'b', ind2: '1').subfields('a').value
    erscheinungsjahr_des_letzten_bandes = source.datafields('425', ind1: 'c', ind2: '1').subfields('a').value
    publikationsdatum_bei_tontraegern    = source.datafields('425', ind1: 'p', ind2: '1').subfields('a').value
    erscheinungsjahr_in_ansetzungsform_super  = source.datafields('425', ind1: 'a', ind2: '2').subfields('a').value
    erscheinungsjahr_des_ersten_bandes_super  = source.datafields('425', ind1: 'b', ind2: '2').subfields('a').value
    #erscheinungsjahr_der_quelle         = source.datafields('595').value

    #if erscheinungsjahr_der_quelle
     # erscheinungsjahr_der_quelle # hat Vorrang vor dem eigentlichen Erscheinungsjahr
    #elsif is_superorder?(source) && (erscheinungsjahr_des_ersten_bandes || erscheinungsjahr_des_letzten_bandes)
     # [
     #   erscheinungsjahr_des_ersten_bandes,
     #   erscheinungsjahr_des_letzten_bandes
     # ]
     # .uniq.join(" - ").strip # returns either "xxxx -", "xxxx - yyyy" or "- yyyy"
    #else
      erscheinungsjahr_in_ansetzungsform || erscheinungsjahr_des_ersten_bandes || erscheinungsjahr_des_letzten_bandes || publikationsdatum_bei_tontraegern || erscheinungsjahr_in_ansetzungsform_super || erscheinungsjahr_des_ersten_bandes_super
    end
  end
#end
