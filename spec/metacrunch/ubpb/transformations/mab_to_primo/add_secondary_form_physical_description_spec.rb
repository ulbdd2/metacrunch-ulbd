describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSecondaryFormPhysicalDescription do
  transformation = transformation_factory(described_class)

  define_field_test '000806191', secondary_form_physical_description: '2 Mikrofiches : 24x'
  define_field_test '001452439', secondary_form_physical_description: nil

  context "for a RDA record" do
    subject do
      mab_xml = mab_xml_builder do
        datafield("649", ind2: "1") do
          subfield("h", "2 Mikrofiches : 24x")
        end
      end

      transformation.call(mab_xml)["secondary_form_physical_description"]
    end

    it { is_expected.to eq("2 Mikrofiches : 24x") }
  end
end
