describe Metacrunch::UBPB::Transformations::MAB2SNR::Publisher do

  it "412_1 works" do
    result = perform(test_412_1)
    expect(result[:display].first).to eq("412_PUBLISHER_1")
    expect(result[:search].first).to eq("412_PUBLISHER_1")
  end

  it "412_2 works" do
    result = perform(test_412_2)
    expect(result[:display].first).to eq("412_PUBLISHER_2")
    expect(result[:search].first).to eq("412_PUBLISHER_2")
  end

  it "417_1 works" do
    result = perform(test_417_1)
    expect(result[:display].first).to eq("417_PUBLISHER_1")
    expect(result[:search].first).to eq("417_PUBLISHER_1")
  end

  it "417_2 works" do
    result = perform(test_417_2)
    expect(result[:display].first).to eq("417_PUBLISHER_2")
    expect(result[:search].first).to eq("417_PUBLISHER_2")
  end

  it "412_1 and 417_1 works" do
    result = perform(test_412_1_and_417_1)
    expect(result[:display][0]).to eq("412_PUBLISHER_1")
    expect(result[:search][0]).to eq("412_PUBLISHER_1")
    expect(result[:display][1]).to eq("417_PUBLISHER_1")
    expect(result[:search][1]).to eq("417_PUBLISHER_1")
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::Publisher,
      source,
      Metacrunch::SNR.new
    )

    display = transformer.target.values("display/publisher")
    search  = transformer.target.values("search/publisher")

    {
      transformer: transformer,
      display: display,
      search: search
    }
  end

  def test_412_1
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="412" ind1="-" ind2="1">
          <subfield code="a">412_PUBLISHER_1</subfield>
        </datafield>
      </record>
    XML
  end

  def test_412_2
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="412" ind1="-" ind2="2">
          <subfield code="a">412_PUBLISHER_2</subfield>
        </datafield>
      </record>
    XML
  end

  def test_417_1
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="417" ind1="-" ind2="1">
          <subfield code="a">417_PUBLISHER_1</subfield>
        </datafield>
      </record>
    XML
  end

  def test_417_2
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="417" ind1="-" ind2="2">
          <subfield code="a">417_PUBLISHER_2</subfield>
        </datafield>
      </record>
    XML
  end

  def test_412_1_and_417_1
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="412" ind1="-" ind2="1">
          <subfield code="a">412_PUBLISHER_1</subfield>
        </datafield>
        <datafield tag="417" ind1="-" ind2="1">
          <subfield code="a">417_PUBLISHER_1</subfield>
        </datafield>
      </record>
    XML
  end

end
