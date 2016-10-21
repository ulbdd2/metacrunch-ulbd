require_relative "../helpers"

# Transform collection code into a readable location name
#
module Metacrunch::ULBD::Transformations::MabToVufind::Helpers::Locationname
  def locationname(collection)
        
      case collection
      
      when 'EG'
         'Zentralbibl.: Erdgeschoss'
      when 'LS' 
         'Zentralbibl.: Lesesaal'
      when '00' 
         'Zentralbibl.: Magazin'
      when '01' 
         'Zentralbibl.: 1. Etage'
      when '02' 
         'Zentralbibl.: 2. Etage'
      when '03' 
         'Zentralbibl.: 3. Etage'
      when '05' 
         'Zentralbibl.: Sonderlesesaal'
      when '07' 
         'Zentralbibl.: Thomas-Mann-Sammlung'
      when '08' 
         'Zentralbibl.: Lehrbuchsammlung'
      when '16' 
         'Zentralbibl.: Sonderlesesaal'
      when '18' 
         'Zentralbibl.: Sonderlesesaal'
      when '19' 
         'Zentralbibl.: Sonderlesesaal'
      when '20' 
         'Zentralbibl.: Sonderlesesaal'
      when '21' 
         'Zentralbibl.: Sonderlesesaal'
      when '25' 
         'VB Geisteswissenschaften'
      when '27' 
         'VB Geisteswissenschaften'
      when '28' 
         'VB Geisteswissenschaften'
      when '29' 
         'VB Geisteswissenschaften'
      when '30' 
         'VB Geisteswissenschaften'
      when '31' 
         'VB Geisteswissenschaften'
      when '32' 
         'VB Geisteswissenschaften'
      when '33' 
         'VB Geisteswissenschaften'
      when '35' 
         'VB Geisteswissenschaften'
      when '37' 
         'VB Geisteswissenschaften'
      when '41' 
         'VB Naturwissenschaften'
      when '42' 
         'VB Naturwissenschaften'
      when '43' 
         'VB Naturwissenschaften'
      when '44' 
         'VB Naturwissenschaften'
      when '45' 
         'VB Naturwissenschaften'
      when '46' 
         'VB Naturwissenschaften'
      when '47' 
         'ZIM'
      when '48' 
         'VB Naturwissenschaften'
      when '49' 
         'Zeitschriftenarchiv Nat'
      when '50' 
         'O.A.S.E.'
      when '51' 
         'Außenmagazin Medizin'
      when '53' 
         'Handapparat med. Inst.'
      when '55' 
         'Inst. Geschichte der Medizin'
      when '56' 
         'Zeitschriftenarchiv Medizin'
      when '57' 
         'Inst. Statistik in der Medizin'
      when '58' 
         'O.A.S.E.: Lehrbuchsammlung'
      when '81' 
         'FB Rechtswissenschaft'
      when '88' 
         'FB Rechtswiss.: LBS'
      when '90' 
         'Außenmagazin'
      when '93' 
         'Außenmagazin Mauerstraße'
        
      else  collection
    end
  end
end
    