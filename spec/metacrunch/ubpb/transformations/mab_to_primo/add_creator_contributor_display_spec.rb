describe Metacrunch::UBPB::Transformations::MabToPrimo::AddCreatorContributorDisplay do
  transformation = transformation_factory(described_class)

  context "a creator with multiple relationship designators" do
    subject do
      mab_xml = mab_xml_builder do
        datafield("100", ind1: "b", ind2: "1") do
          subfield("p", "Jahn, Andrea")
          subfield("d", "1964-")
          subfield("4", "edt")
          subfield("4", "wst")
        end
      end

      transformation.call(mab_xml)["creator_contributor_display"]
    end

    it { is_expected.to eq("Jahn, Andrea [Hrsg.]") }
  end

  define_field_test '001830953', creator_contributor_display: "Pott, Klaus Friedrich [Hrsg.]"
end
