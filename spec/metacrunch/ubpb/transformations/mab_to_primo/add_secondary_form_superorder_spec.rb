describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSecondaryFormSuperorder do
  transformation = transformation_factory(described_class)

  define_field_test '000806191', secondary_form_superorder: "{\"ht_number\":\"HT006670284\",\"label\":\"Edition Wissenschaft : Reihe Chemie ; 240\",\"volume_count\":\"240\"}"
  define_field_test '000977734', secondary_form_superorder: [
    "{\"ht_number\":null,\"label\":\"Zeitschriften der HAAB Weimar. Projekt Sicherungsverfilmung der HAAB Weimar\",\"volume_count\":null}",
    "{\"ht_number\":null,\"label\":\"Faustsammlung der HAAB Weimar\",\"volume_count\":null}"
  ]

  define_field_test '001452439', secondary_form_superorder: "{\"ht_number\":null,\"label\":\"Digitale Sammlungen der Universitätsbibliothek Paderborn\",\"volume_count\":null}"

  context "for a RDA record" do
    subject do
      mab_xml = mab_xml_builder do
        datafield("649", ind2: "1") do
          subfield("i", "Elektronische Reproduktion von")
          subfield("a", "Fichard, Johann Carl von")
          subfield("t", "&lt;&lt;Die&gt;&gt; Entstehung der Reichsstadt Frankfurt am Main, und der Verhältnisse ihrer Bewohner")
          subfield("d", "Frankfurt")
          subfield("e", "Andreä")
          subfield("f", "1819")
          subfield("h", "365 Seiten")
          subfield("n", "Digitalisat von: Bayerische Staatsbibliothek: Germ.sp. 142 a")
          subfield("9", "BV001588105")
        end

        datafield("649", ind1: "a", ind2:"1") do
          subfield("i", "Nachdruck von")
          subfield("a", "Accumulatoren-Fabrik, Berlin; Hagen")
          subfield("t", "Lokomotiven mit Accumulatorenbetrieb")
          subfield("d", "Berlin : Accumulatoren-Fabrik Aktien-Gesellschaft, [ca. 1905]")
          subfield("h", "Band")
          subfield("9", "HT017415971")
        end  
      end

      transformation.call(mab_xml)["secondary_form_superorder"]
    end

    it {
      is_expected.to eq([
        "{\"ht_number\":null,\"label\":\"\\u003c\\u003cDie\\u003e\\u003e Entstehung der Reichsstadt Frankfurt am Main, und der Verhältnisse ihrer Bewohner\",\"volume_count\":null}",
        "{\"ht_number\":\"HT017415971\",\"label\":\"Lokomotiven mit Accumulatorenbetrieb\",\"volume_count\":null}"
      ])
    }
  end
end
