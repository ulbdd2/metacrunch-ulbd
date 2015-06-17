describe Metacrunch::UBPB::Transformations::MAB2SNR::PlaceOfPublication do

  it "410_1 works" do
    result = perform(test_410_1)
    expect(result[:display].first).to eq("410_PLACE_1")
    expect(result[:search].first).to eq("410_PLACE_1")
  end

  it "410_2 works" do
    result = perform(test_410_2)
    expect(result[:display].first).to eq("410_PLACE_2")
    expect(result[:search].first).to eq("410_PLACE_2")
  end

  it "415_1 works" do
    result = perform(test_415_1)
    expect(result[:display].first).to eq("415_PLACE_1")
    expect(result[:search].first).to eq("415_PLACE_1")
  end

  it "415_2 works" do
    result = perform(test_415_2)
    expect(result[:display].first).to eq("415_PLACE_2")
    expect(result[:search].first).to eq("415_PLACE_2")
  end

  it "410_1 and 415_1 works" do
    result = perform(test_410_1_and_415_1)
    expect(result[:display][0]).to eq("410_PLACE_1")
    expect(result[:search][0]).to eq("410_PLACE_1")
    expect(result[:display][1]).to eq("415_PLACE_1")
    expect(result[:search][1]).to eq("415_PLACE_1")
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::PlaceOfPublication,
      source,
      Metacrunch::SNR.new
    )

    display = transformer.target.values("display/place_of_publication")
    search  = transformer.target.values("search/place_of_publication")

    {
      transformer: transformer,
      display: display,
      search: search
    }
  end

  def test_410_1
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="410" ind1="-" ind2="1">
          <subfield code="a">410_PLACE_1</subfield>
        </datafield>
      </record>
    XML
  end

  def test_410_2
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="410" ind1="-" ind2="2">
          <subfield code="a">410_PLACE_2</subfield>
        </datafield>
      </record>
    XML
  end

  def test_415_1
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="415" ind1="-" ind2="1">
          <subfield code="a">415_PLACE_1</subfield>
        </datafield>
      </record>
    XML
  end

  def test_415_2
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="415" ind1="-" ind2="2">
          <subfield code="a">415_PLACE_2</subfield>
        </datafield>
      </record>
    XML
  end

  def test_410_1_and_415_1
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="410" ind1="-" ind2="1">
          <subfield code="a">410_PLACE_1</subfield>
        </datafield>
        <datafield tag="415" ind1="-" ind2="1">
          <subfield code="a">415_PLACE_1</subfield>
        </datafield>
      </record>
    XML
  end

end
