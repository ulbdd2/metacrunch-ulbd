describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSuperorderDisplay do
  transformation = transformation_factory(described_class)

  # superorder label with leading '...' but without ';' or ':' between dots and label
  define_field_test '000000872', superorder_display: [
    "{\"ht_number\":\"HT001310809\",\"label\":\"Wissenschaftliche Tagung der Arbeitsgemeinschaft für Klinische Diätetik\",\"volume_count\":\"Bd. 2\",\"label_additions\":null}",
    "{\"ht_number\":\"HT002182783\",\"label\":\"Aktuelle Ernährungsmedizin\",\"volume_count\":\"[3], Suppl\",\"label_additions\":null}"
  ]

  # for the label everything behind ':' should be removed
  define_field_test '000162669', superorder_display: "{\"ht_number\":\"HT001231518\",\"label\":\"Handbuch der Dogmengeschichte\",\"volume_count\":\"Bd. 1, Das Dasein im Glauben ; Fasz. 4\",\"label_additions\":null}"
  define_field_test '000178500', superorder_display: "{\"ht_number\":\"HT001231518\",\"label\":\"Handbuch der Dogmengeschichte\",\"volume_count\":\"Bd. 3, Christologie, Soteriologie, Ekklesiologie, Mariologie, Gnadenlehre ; Fasz.4\",\"label_additions\":null}"
  define_field_test '000297043', superorder_display: "{\"ht_number\":\"HT001231518\",\"label\":\"Handbuch der Dogmengeschichte\",\"volume_count\":\"Bd. 4, Sakramente, Eschatologie ; Fasz. 1\",\"label_additions\":null}" 

  # << ... >> should be removed
  define_field_test '000958473', superorder_display: [
    "{\"ht_number\":\"HT001231617\",\"label\":\"Hessische Forschungen\",\"volume_count\":\"Bd. 47\",\"label_additions\":null}",
    "{\"ht_number\":\"HT003779625\",\"label\":\"Die Geschichte unserer Heimat\",\"volume_count\":\"Bd. 45\",\"label_additions\":null}"
  ]

  # label additions
  define_field_test '000160412', superorder_display: "{\"ht_number\":\"HT001237362\",\"label\":\"Historische Zeitschrift\",\"volume_count\":\"[N.F.],1\",\"label_additions\":[\"Beiheft\"]}" 
  define_field_test '001006945', superorder_display: [
    "{\"ht_number\":\"HT002919097\",\"label\":\"Urkundenregesten zur Tätigkeit des deutschen Königs- und Hofgerichts bis 1451\",\"volume_count\":\"Bd. 14\",\"label_additions\":null}",
    "{\"ht_number\":\"HT003165994\",\"label\":\"Quellen und Forschungen zur höchsten Gerichtsbarkeit im alten Reich\",\"volume_count\":\"Bd. 14\",\"label_additions\":[\"Sonderreihe\"]}"
  ]

  # sometimes there are multiple 451 fields with one startingen with '...', if this is the case, try the other one
  define_field_test '000562878', superorder_display: [
    "{\"ht_number\":\"HT003809808\",\"label\":\"Management \\u0026 marketing dictionary\",\"volume_count\":\"Bd. 1\",\"label_additions\":null}",
    "{\"ht_number\":\"HT002100889\",\"label\":\"dtv\",\"volume_count\":\"5815 : Beck-Wirtschaftsberater\",\"label_additions\":null}"
  ]

  # don't remove superorders without HT-Number
  define_field_test '001559463', superorder_display: "{\"ht_number\":null,\"label\":\"Schöningh Schulbuch\",\"volume_count\":null,\"label_additions\":null}"

  context "for a RDA record" do
    subject do
      mab_xml = mab_xml_builder do
        datafield("451", ind2: "1") do
          subfield("a", "Wilhelm Diltheys Gesammelte Schriften")
          subfield("v", "21. Band")
          subfield("a", "Psychologie als Erfahrungswissenschaft")
          subfield("v", "1. Teil")
        end
      end

      transformation.call(mab_xml)["superorder_display"]
    end

    it { is_expected.to eq("{\"ht_number\":null,\"label\":\"Wilhelm Diltheys Gesammelte Schriften\",\"volume_count\":\"21. Band\",\"label_additions\":null}") }
  end
end
