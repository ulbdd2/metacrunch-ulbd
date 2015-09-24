describe Metacrunch::UBPB::Transformations::MabToPrimo::AddIssn do
  transformation = transformation_factory(described_class)

  define_field_test '000637121', issn: ['0935-4018', '1437-2940']

  context "secondary forms issns" do
    context "for a RDA record" do
      subject do
        mab_xml = mab_xml_builder do
          datafield("649", ind2: "1") do
            subfield("x", "0935-4018")
          end

          datafield("649", ind2: "1") do
            subfield("x", "1437-2940")
            subfield("x", "1437-2941")
          end
        end

        transformation.call(mab_xml)["issn"]
      end

      it { is_expected.to eq(["0935-4018", "1437-2940", "1437-2941"]) }
    end
  end
end
