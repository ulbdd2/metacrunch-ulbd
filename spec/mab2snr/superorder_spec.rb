describe Metacrunch::UBPB::Transformations::MAB2SNR::Superorder do

  it "is superorder if 051(0) is 'n'" do
    result = perform(test_field("051", "n"))
    expect(result[:superorder]).to be(true)
  end

  it "is superorder if 051(0) is 't'" do
    result = perform(test_field("051", "t"))
    expect(result[:superorder]).to be(true)
  end

  it "is no superorder if 051(0) is not 'n' or 't'" do
    result = perform(test_field("051", "x"))
    expect(result[:superorder]).to be(false)
  end

  it "is superorder if 052(0) is 'p'" do
    result = perform(test_field("052", "p"))
    expect(result[:superorder]).to be(true)
  end

  it "is superorder if 052(0) is 'r'" do
    result = perform(test_field("052", "r"))
    expect(result[:superorder]).to be(true)
  end

  it "is superorder if 052(0) is 'z'" do
    result = perform(test_field("052", "z"))
    expect(result[:superorder]).to be(true)
  end

  it "is no superorder if 052(0) is 'p' or 'r' or 'z'" do
    result = perform(test_field("052", "x"))
    expect(result[:superorder]).to be(false)
  end


private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::Superorder,
      source,
      Metacrunch::SNR.new
    )

    superorder = transformer.target.values("control/superorder").first

    {
      transformer: transformer,
      superorder: superorder
    }
  end

  def test_field(field, value)
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <controlfield tag="#{field}">#{value}||||</controlfield>
      </record>
    XML
  end

end
