describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSecondaryFormPublisher do
  transformation = transformation_factory(described_class)

  define_field_test '000806191', secondary_form_publisher: 'Marburg : Tectum-Verl.'
  define_field_test '001452439', secondary_form_publisher: 'Paderborn : Universitätsbibliothek Paderborn'

  context "for a RDA record" do
    subject do
      mab_xml = mab_xml_builder do
        datafield("649", ind2: "1") do
          subfield("i", "Nachdruck von")
          subfield("t", "Adreßbuch der Wartburgstadt Eisenach")
          subfield("d", "Weimar : Thüringer Volksverlag, 1950")
          subfield("h", "Band")
        end

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
      end

      transformation.call(mab_xml)["secondary_form_publisher"]
    end

    it { is_expected.to eq(["Weimar : Thüringer Volksverlag", "Frankfurt : Andreä"]) }
  end
end
