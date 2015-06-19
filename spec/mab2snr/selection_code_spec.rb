describe Metacrunch::UBPB::Transformations::MAB2SNR::SelectionCode do

  it "works" do
    result = perform(test_default)
    expect(result[:codes][0]).to eq("abc")
    expect(result[:codes][1]).to eq("xyz")
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::SelectionCode,
      source,
      Metacrunch::SNR.new
    )

    codes = transformer.target.values("control/selection_code")

    {
      transformer: transformer,
      codes: codes
    }
  end

  def test_default
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="078" ind1="e" ind2=" ">
          <subfield code="a">abc</subfield>
        </datafield>
        <datafield tag="078" ind1="r" ind2=" ">
          <subfield code="a">xyz</subfield>
        </datafield>
      </record>
    XML
  end

end
