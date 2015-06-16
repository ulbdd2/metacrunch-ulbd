describe "mab2snr#creation_date" do
  let(:target) do
    transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::CreationDate,
      mab,
      Metacrunch::SNR.new
    )
  end

  context "control section" do
    it "creation_date should be 20070905" do
      date = target.section("control").fields[0].value
      expect(date).to eq("20070905")
    end
  end

private

  def mab
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="LOC" ind1=" " ind2=" ">
          <subfield code="k">20070905</subfield>
        </datafield>
        <datafield tag="LOC" ind1=" " ind2=" ">
          <subfield code="k">20070906</subfield>
        </datafield>
      </record>
    XML
  end

end
