describe Metacrunch::UBPB::Transformations::MAB2SNR::Description do

  it "can have a prefix" do
    result = perform(test_without_prefix("405"))
    expect(result[:display]).to eq("DESCRIPTION")
    expect(result[:search]).to eq("DESCRIPTION")

    result = perform(test_with_prefix("405"))
    expect(result[:display]).to eq("PREFIX: DESCRIPTION")
    expect(result[:search]).to eq("PREFIX: DESCRIPTION")
  end

  it "works" do
    [405, 522, 523, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510,
     511, 512, 513, 514, 515, 516, 517, 518, 519, 536, 537].each do |i|
      result = perform(test_with_prefix(i.to_s))
      expect(result[:display]).to eq("PREFIX: DESCRIPTION")
      expect(result[:search]).to eq("PREFIX: DESCRIPTION")
    end
  end

  it "537ap will be ignored for journals" do
    result = perform(test_537_journal)
    expect(result[:display]).to eq(nil)
    expect(result[:search]).to eq(nil)
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::Description,
      source,
      Metacrunch::SNR.new
    )

    display = transformer.target.values("display/description").first
    search  = transformer.target.values("search/description").first

    {
      transformer: transformer,
      display: display,
      search: search
    }
  end

  def test_without_prefix(field)
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="405" ind1="-" ind2="1">
          <subfield code="a">DESCRIPTION</subfield>
        </datafield>
      </record>
    XML
  end

  def test_with_prefix(field)
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="#{field}" ind1="-" ind2="1">
          <subfield code="a">DESCRIPTION</subfield>
          <subfield code="p">PREFIX</subfield>
        </datafield>
      </record>
    XML
  end

  def test_537_journal
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <controlfield tag="052">p</controlfield>
        <datafield tag="537" ind1="-" ind2="1">
          <subfield code="a">DESCRIPTION</subfield>
          <subfield code="p">PREFIX</subfield>
        </datafield>
      </record>
    XML
  end

end
