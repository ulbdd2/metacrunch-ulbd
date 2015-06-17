describe Metacrunch::UBPB::Transformations::MAB2SNR::DateOfPublication do

  it "425a works" do
    result = perform(test_425a)

    expect(result[:display]).to eq("1998")
    expect(result[:search]).to eq("1998")
    expect(result[:sort]).to eq("1998")
  end

  it "425p works" do
    result = perform(test_425p)

    expect(result[:display]).to eq("1999")
    expect(result[:search]).to eq("1999")
    expect(result[:sort]).to eq("1999")
  end

  it "595 works and superseeds all other dates" do
    result = perform(test_595)

    expect(result[:display]).to eq("1999")
    expect(result[:search]).to eq("1999")
    expect(result[:sort]).to eq("1999")
  end

  it "425b works" do
    result = perform(test_425b)

    expect(result[:display]).to eq("2000 –")
    expect(result[:search]).to eq("2000")
    expect(result[:sort]).to eq("2000")
  end

  it "425c works" do
    result = perform(test_425c)

    expect(result[:display]).to eq("– 2010")
    expect(result[:search]).to eq("2010")
    expect(result[:sort]).to eq("2010")
  end

  it "425b and 425c works" do
    result = perform(test_425b_and_425c)

    expect(result[:display]).to eq("2000 – 2010")
    expect(result[:search]).to eq("2000")
    expect(result[:sort]).to eq("2000")
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::DateOfPublication,
      source,
      Metacrunch::SNR.new
    )

    display = transformer.target.values("display/date_of_publication").first
    search  = transformer.target.values("search/date_of_publication").first
    sort    = transformer.target.values("sort/date_of_publication").first

    {
      transformer: transformer,
      display: display,
      search: search,
      sort: sort
    }
  end

  def test_425a
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="425" ind1="a" ind2="1">
          <subfield code="a">1998</subfield>
        </datafield>
      </record>
    XML
  end

  def test_425p
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="425" ind1="p" ind2="1">
          <subfield code="a">1999</subfield>
        </datafield>
      </record>
    XML
  end

  def test_595
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="425" ind1="a" ind2="1">
          <subfield code="a">1998</subfield>
        </datafield>
        <datafield tag="595" ind1=" " ind2=" ">
          <subfield code="a">1999</subfield>
        </datafield>
      </record>
    XML
  end

  def test_425b
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <controlfield tag="051">n</controlfield>
        <datafield tag="425" ind1="b" ind2="1">
          <subfield code="a">2000</subfield>
        </datafield>
      </record>
    XML
  end

  def test_425c
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <controlfield tag="051">n</controlfield>
        <datafield tag="425" ind1="c" ind2="1">
          <subfield code="a">2010</subfield>
        </datafield>
      </record>
    XML
  end

  def test_425b_and_425c
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <controlfield tag="051">n</controlfield>
        <datafield tag="425" ind1="b" ind2="1">
          <subfield code="a">2000</subfield>
        </datafield>
        <datafield tag="425" ind1="c" ind2="1">
          <subfield code="a">2010</subfield>
        </datafield>
      </record>
    XML
  end

end
