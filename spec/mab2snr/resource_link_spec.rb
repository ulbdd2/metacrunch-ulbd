describe Metacrunch::UBPB::Transformations::MAB2SNR::ResourceLink do

  it "655 works" do
    result = perform(test_default)
    expect(result[:links].first[:url]).to eq("http://example.com")
    expect(result[:links].first[:label]).to eq("SOME LABEL")
  end

  it "label is optional" do
    result = perform(test_default_no_label)
    expect(result[:links].first[:url]).to eq("http://example.com")
    expect(result[:links].first[:label]).to be_nil
  end

  it "ignores HBZ TOC" do
    result = perform(test_hbz_toc)
    expect(result[:links]).to be_empty
  end

  it "ignores BVB TOC" do
    result = perform(test_bvb_toc)
    expect(result[:links]).to be_empty
  end

  it "ignores Adam TOC" do
    result = perform(test_adam_toc)
    expect(result[:links]).to be_empty
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::ResourceLink,
      source,
      Metacrunch::SNR.new
    )

    links = transformer.target.values("link/resource")

    {
      transformer: transformer,
      links: links
    }
  end

  def test_default
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="655" ind1=" " ind2=" ">
          <subfield code="u">http://example.com</subfield>
          <subfield code="y">SOME LABEL</subfield>
        </datafield>
      </record>
    XML
  end

  def test_default_no_label
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="655" ind1=" " ind2=" ">
          <subfield code="u">http://example.com</subfield>
        </datafield>
      </record>
    XML
  end

  def test_hbz_toc
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="655" ind1=" " ind2=" ">
          <subfield code="3">Inhaltsverzeichnis</subfield>
          <subfield code="u">http://example.com</subfield>
          <subfield code="y">SOME LABEL</subfield>
        </datafield>
      </record>
    XML
  end

  def test_bvb_toc
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="655" ind1=" " ind2=" ">
          <subfield code="z">Inhaltsverzeichnis</subfield>
          <subfield code="u">http://example.com</subfield>
          <subfield code="y">SOME LABEL</subfield>
        </datafield>
      </record>
    XML
  end

  def test_adam_toc
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="655" ind1=" " ind2=" ">
          <subfield code="t">VIEW</subfield>
          <subfield code="u">http://example.com</subfield>
          <subfield code="y">SOME LABEL</subfield>
        </datafield>
      </record>
    XML
  end

end
