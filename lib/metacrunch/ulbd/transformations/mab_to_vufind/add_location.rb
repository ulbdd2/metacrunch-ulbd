require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddLocation < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "location_facet", location) : location
  end

  private

  def location
    r = []
    
    source.datafields('LOC').each do |field|
      field_b = field.subfields('b').value

      locationname = case
      
        when (field_b == 'LS') then 'Zentralbibl. Ergeschoss'
        when (field_b == '00') then 'Zentralbibl. Magazin'
        when (field_b == '01') then 'Zentralbibl. 1. Etage'
        when (field_b == '02') then 'Zentralbibl. 2. Etage'
        when (field_b == '03') then 'Zentralbibl. 3. Etage'
        when (field_b == '05') then 'Zentralbibl. Sonderlesesaal'
        when (field_b == '07') then 'Zentralbibl. Thomas-Mann-Sammlung'
        when (field_b == '08') then 'Zentralbibl. Lehrbuchsammlung'
        when (field_b == '16') then 'Zentralbibl. Sonderlesesaal'
        when (field_b == '18') then 'Zentralbibl. Sonderlesesaal'
        when (field_b == '19') then 'Zentralbibl. Sonderlesesaal'
        when (field_b == '20') then 'Zentralbibl. Sonderlesesaal'
        when (field_b == '21') then 'Zentralbibl. Sonderlesesaal'
        when (field_b == '25') then 'VB Geisteswissenschaften'
        when (field_b == '27') then 'VB Geisteswissenschaften'
        when (field_b == '28') then 'VB Geisteswissenschaften'
        when (field_b == '29') then 'VB Geisteswissenschaften'
        when (field_b == '30') then 'VB Geisteswissenschaften'
        when (field_b == '31') then 'VB Geisteswissenschaften'
        when (field_b == '32') then 'VB Geisteswissenschaften'
        when (field_b == '33') then 'VB Geisteswissenschaften'
        when (field_b == '35') then 'VB Geisteswissenschaften'
        when (field_b == '37') then 'VB Geisteswissenschaften'
        when (field_b == '41') then 'VB Naturwissenschaften'
        when (field_b == '42') then 'VB Naturwissenschaften'
        when (field_b == '43') then 'VB Naturwissenschaften'
        when (field_b == '44') then 'VB Naturwissenschaften'
        when (field_b == '45') then 'VB Naturwissenschaften'
        when (field_b == '46') then 'VB Naturwissenschaften'
        when (field_b == '47') then 'ZIM'
        when (field_b == '48') then 'VB Naturwissenschaften'
        when (field_b == '49') then 'Zeitschriftenarchiv Nat'
        when (field_b == '50') then 'O.A.S.E.'
        when (field_b == '51') then 'Außenmagazin Medizin'
        when (field_b == '53') then 'Handapparat med. Inst.'
        when (field_b == '55') then 'Inst. Geschichte der Medizin'
        when (field_b == '56') then 'Zeitschriftenarchiv Medizin'
        when (field_b == '57') then 'Inst. Statistik in der Medizin'
        when (field_b == '58') then 'O.A.S.E.: Lehrbuchsammlung'
        when (field_b == '81') then 'FB Rechtswissenschaft'
        when (field_b == '88') then 'FB Rechtswiss. LBS'
        when (field_b == '90') then 'Außenmagazin'
        when (field_b == '93') then 'Außenmagazin Mauerstraße'

        else nil
      end
    
      r << locationname
    end
    
    r.map(&:presence).compact.uniq
  end
end
