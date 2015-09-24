describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSuperorder do
  transformation = transformation_factory(described_class)

  # check for superorders of secondary forms (mab 623 and 629)
  define_field_test '000806191', superorder: 'HT006670284'
  define_field_test '000844686', superorder: 'HT007082773'
  define_field_test '001452439', superorder: nil

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

      transformation.call(mab_xml)["superorder"]
    end

    it { is_expected.to eq(["BV001588105", "HT017415971"]) }
  end
end
