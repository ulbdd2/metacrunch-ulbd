require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddLocation < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "location_str", location) : location
  end

  private

  def location
    collection = source.datafields('LOC').subfields('b').value
    collection_str = case
      
      when (collection == 'LS') then 'Zentralbibl.: Ergeschoss'
      when (collection == '00') then 'Zentralbibl.: Magazin'
      when (collection == '01') then 'Zentralbibl.: 1. Etage'
      when (collection == '02') then 'Zentralbibl.: 2. Etage'
      when (collection == '03') then 'Zentralbibl.: 3. Etage'
      when (collection == '05') then 'Zentralbibl.: Sonderlesesaal'
      when (collection == '07') then 'Zentralbibl.: Thomas-Mann-Sammlung'
      when (collection == '08') then 'Zentralbibl.: Lehrbuchsammlung'
      when (collection == '16') then 'Zentralbibl.: Sonderlesesaal'
      when (collection == '18') then 'Zentralbibl.: Sonderlesesaal'
      when (collection == '19') then 'Zentralbibl.: Sonderlesesaal'
      when (collection == '20') then 'Zentralbibl.: Sonderlesesaal'
      when (collection == '21') then 'Zentralbibl.: Sonderlesesaal'
      when (collection == '25') then 'VB Geisteswissenschaften'
      when (collection == '27') then 'VB Geisteswissenschaften'
      when (collection == '28') then 'VB Geisteswissenschaften'
      when (collection == '29') then 'VB Geisteswissenschaften'
      when (collection == '30') then 'VB Geisteswissenschaften'
      when (collection == '31') then 'VB Geisteswissenschaften'
      when (collection == '32') then 'VB Geisteswissenschaften'
      when (collection == '33') then 'VB Geisteswissenschaften'
      when (collection == '35') then 'VB Geisteswissenschaften'
      when (collection == '37') then 'VB Geisteswissenschaften'
      when (collection == '41') then 'VB Naturwissenschaften'
      when (collection == '42') then 'VB Naturwissenschaften'
      when (collection == '43') then 'VB Naturwissenschaften'
      when (collection == '44') then 'VB Naturwissenschaften'
      when (collection == '45') then 'VB Naturwissenschaften'
      when (collection == '46') then 'VB Naturwissenschaften'
      when (collection == '47') then 'ZIM'
      when (collection == '48') then 'VB Naturwissenschaften'
      when (collection == '49') then 'Zeitschriftenarchiv Nat'
      when (collection == '50') then 'O.A.S.E.'
      when (collection == '51') then 'Außenmagazin Medizin'
      when (collection == '53') then 'Handapparat med. Inst.'
      when (collection == '55') then 'Inst. Geschichte der Medizin'
      when (collection == '56') then 'Zeitschriftenarchiv Medizin'
      when (collection == '57') then 'Inst. Statistik in der Medizin'
      when (collection == '58') then 'O.A.S.E.: Lehrbuchsammlung'
      when (collection == '81') then 'FB Rechtswissenschaft'
      when (collection == '88') then 'FB Rechtswiss.: LBS'
      when (collection == '90') then 'Außenmagazin'
      when (collection == '93') then 'Außenmagazin Mauerstraße'
        
      else nil
    end
    
    collection_str
  end
end
