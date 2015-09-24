describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSecondaryFormCreationdate do
  transformation = transformation_factory(described_class)

  define_field_test '000806191', secondary_form_creationdate: nil
  define_field_test '000844686', secondary_form_creationdate: '2001'
  define_field_test '001452439', secondary_form_creationdate: '2012'

  context "for a RDA record" do
    subject do
      mab_xml = mab_xml_builder do
        datafield("649", ind2: "1") do
          subfield("f", "1983")
        end

        datafield("649", ind2: "1") do
          subfield("f", "1983")
        end

        datafield("649", ind2: "1") do
          subfield("f", "1988")
        end
      end

      transformation.call(mab_xml)["secondary_form_creationdate"]
    end

    it { is_expected.to eq(["1983", "1988"]) }
  end
end
