require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./helpers/is_superorder"
#require_relative "./add_creationdate"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreationdateSearch < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::IsSuperorder
  
  def call
    target ? Metacrunch::Hash.add(target, "creationdate_txt", creationdate_search) : creationdate_search
  end

  private

  def creationdate_search
    #if date = creationdate
      #date.gsub(/[^0-9]/i, '') # Entferne alle nicht numerischen Zeichen
    #end
    
    erscheinungsjahr_in_ansetzungsform  = source.datafields('425', ind1: 'a', ind2: '1').subfields('a').value
    erscheinungsjahr_des_ersten_bandes  = source.datafields('425', ind1: 'b', ind2: '1').subfields('a').value
    #erscheinungsjahr_des_letzten_bandes = source.datafields('425', ind1: 'c', ind2: '1').subfields('a').value
    publikationsdatum_bei_tonträgern    = source.datafields('425', ind1: 'p', ind2: '1').subfields('a').value
    erscheinungsjahr_der_quelle         = source.datafields('595').value

    if erscheinungsjahr_der_quelle
      erscheinungsjahr_der_quelle # hat Vorrang vor dem eigentlichen Erscheinungsjahr
    #elsif is_superorder?(source) && (erscheinungsjahr_des_ersten_bandes || erscheinungsjahr_des_letzten_bandes)
     # [
      #  c,
       # erscheinungsjahr_des_letzten_bandes
      #]
      #.uniq.join.strip # returns either "xxxx -", "xxxx - yyyy" or "- yyyy"
    else
      erscheinungsjahr_des_ersten_bandes || erscheinungsjahr_in_ansetzungsform || publikationsdatum_bei_tonträgern
    end
  end

  #private

  #def creationdate
   # target.try(:[], "creationdate") || self.class.parent::AddCreationdate.new(source: source).call
  #end
end
