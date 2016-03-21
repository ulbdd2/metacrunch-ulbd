describe Metacrunch::UBPB::Transformations::MabToPrimo::AddIsbn do
  transformation = transformation_factory(described_class)

  context "secondary forms isbns" do
    context "for a RDA record" do
      subject do
        mab_xml = mab_xml_builder do
          datafield("649", ind2: "1") do
            subfield("z", "3-8155-0186-5")
          end

          datafield("649", ind2: "1") do
            subfield("z", "3-930673-19-3")
            subfield("z", "978-3-8273-2478-8")
          end
        end

        transformation.call(mab_xml)["isbn"]
      end

      it { is_expected.to eq(["3-8155-0186-5", "3-930673-19-3", "978-3-8273-2478-8"]) }
    end
  end

  define_field_test '001705215', isbn: ["978-3-89710-549-2", "978-3-374-03418-5", "978-3-89710-549-5"]
end
