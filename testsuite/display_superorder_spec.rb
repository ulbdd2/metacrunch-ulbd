describe (field_name = "display/superorder") do
  [
    # superorder label with leading '...' but without ';' or ':' between dots and label
    ["PAD01.000000872.PRIMO.xml", [
      {"identifier"=>{"hbz_id"=>"HT001310809"}, "title"=>"Wissenschaftliche Tagung der Arbeitsgemeinschaft für Klinische Diätetik", "volume"=>"2"},
      {"identifier"=>{"hbz_id"=>"HT002182783"}, "title"=>"Aktuelle Ernährungsmedizin", "volume"=>"[3], Suppl" }
    ]],

    # for the label everything behind ':' should be removed
    ["PAD01.000162669.PRIMO.xml", {"identifier"=>{"hbz_id"=>"HT001231518"}, "title"=>"Handbuch der Dogmengeschichte", "volume"=>"Bd. 1, Das Dasein im Glauben ; Fasz. 4"}],
    ["PAD01.000178500.PRIMO.xml", {"identifier"=>{"hbz_id"=>"HT001231518"}, "title"=>"Handbuch der Dogmengeschichte", "volume"=>"Bd. 3, Christologie, Soteriologie, Ekklesiologie, Mariologie, Gnadenlehre ; Fasz.4"}],
    ["PAD01.000297043.PRIMO.xml", {"identifier"=>{"hbz_id"=>"HT001231518"}, "title"=>"Handbuch der Dogmengeschichte", "volume"=>"Bd. 4, Sakramente, Eschatologie ; Fasz. 1"}],

    # << ... >> should be removed
    ["PAD01.000958473.PRIMO.xml", [
      {"identifier"=>{"hbz_id"=>"HT001231617"}, "title"=>"Hessische Forschungen", "volume"=>"47"},
      {"identifier"=>{"hbz_id"=>"HT003779625"}, "title"=>"Die Geschichte unserer Heimat", "volume"=>"45"}
    ]],

    # label additions
    ["PAD01.000160412.PRIMO.xml", {"identifier"=>{"hbz_id"=>"HT001237362"}, "title"=>"Historische Zeitschrift : Beiheft", "volume"=>"[N.F.],1"}],
    ["PAD01.001006945.PRIMO.xml", [
      {"identifier"=>{"hbz_id"=>"HT002919097"}, "title"=>"Urkundenregesten zur Tätigkeit des deutschen Königs- und Hofgerichts bis 1451", "volume"=>"14"},
      {"identifier"=>{"hbz_id"=>"HT003165994"}, "title"=>"Quellen und Forschungen zur höchsten Gerichtsbarkeit im alten Reich : Sonderreihe", "volume"=>"14"}
    ]],

    # sometimes there are multiple 451 fields with one startingen with '...', if this is the case, try the other one
    ["PAD01.000562878.PRIMO.xml", [
      {"identifier"=>{"hbz_id"=>"HT003809808"}, "title"=>"Management & marketing dictionary", "volume"=>"1"},
      {"identifier"=>{"hbz_id"=>"HT002100889"}, "title"=>"dtv", "volume"=>"5815 : Beck-Wirtschaftsberater"}
    ]],

    # don't remove superorders without HT-Number
    ["PAD01.001559463.PRIMO.xml", {"title"=>"Schöningh Schulbuch"}]
  ]
  .each do |_filename, _expected_value|
    context "for #{_filename}" do
      subject do
        perform_step(Metacrunch::UBPB::Transformations::MAB2SNR::Superorder, read_mab_file(_filename)).target.values(field_name)
      end

      it { is_expected.to eq([_expected_value].flatten(1)) }
    end
  end
end
