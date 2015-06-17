describe Metacrunch::UBPB::Transformations::MAB2SNR::Edition do

  it "403_1 works" do
    result = perform(test_403_1)
    expect(result[:display]).to eq("2. PRINT.")
    expect(result[:search]).to eq("2. PRINT.")
    expect(result[:sort]).to eq(2)
  end

  it "403_2 works" do
    result = perform(test_403_2)
    expect(result[:display]).to eq("2. ED.")
    expect(result[:search]).to eq("2. ED.")
    expect(result[:sort]).to eq(2)
  end

  it "407_1 works" do
    result = perform(test_407_1)
    expect(result[:display]).to eq("3 XYZ")
    expect(result[:search]).to eq("3 XYZ")
    expect(result[:sort]).to eq(3)
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::Edition,
      source,
      Metacrunch::SNR.new
    )

    display = transformer.target.values("display/edition").first
    search  = transformer.target.values("search/edition").first
    sort    = transformer.target.values("sort/edition").first

    {
      transformer: transformer,
      display: display,
      search: search,
      sort: sort
    }
  end

  def test_403_1
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="403" ind1="-" ind2="1">
          <subfield code="a">2. PRINT.</subfield>
        </datafield>
      </record>
    XML
  end

  def test_403_2
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="403" ind1="-" ind2="2">
          <subfield code="a">2. ED.</subfield>
        </datafield>
      </record>
    XML
  end

  def test_407_1
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="407" ind1="-" ind2="1">
          <subfield code="a">3 XYZ</subfield>
        </datafield>
      </record>
    XML
  end

end
