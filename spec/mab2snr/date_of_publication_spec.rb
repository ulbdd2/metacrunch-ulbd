describe Metacrunch::UBPB::Transformations::MAB2SNR::DateOfPublication do

  context "#display_date" do
    it "425a works" do
      transformer = transform_source(test_425a)
      expect(transformer.step.display_date).to eq("1998")
    end

    it "425p works" do
      transformer = transform_source(test_425p)
      expect(transformer.step.display_date).to eq("1999")
    end

    it "595 works and superseeds all other dates" do
      transformer = transform_source(test_595)
      expect(transformer.step.display_date).to eq("1999")
    end

    it "425b works" do
      transformer = transform_source(test_425b)
      expect(transformer.step.display_date).to eq("2000 –")
    end

    it "425c works" do
      transformer = transform_source(test_425c)
      expect(transformer.step.display_date).to eq("– 2010")
    end

    it "425b and 425c works" do
      transformer = transform_source(test_425b_and_425c)
      expect(transformer.step.display_date).to eq("2000 – 2010")
    end
  end

  context "#search_date" do
    it "425a works" do
      transformer = transform_source(test_425a)
      expect(transformer.step.search_date).to eq("1998")
    end

    it "425p works" do
      transformer = transform_source(test_425p)
      expect(transformer.step.search_date).to eq("1999")
    end

    it "595 works and superseeds all other dates" do
      transformer = transform_source(test_595)
      expect(transformer.step.search_date).to eq("1999")
    end

    it "425b works" do
      transformer = transform_source(test_425b)
      expect(transformer.step.search_date).to eq("2000")
    end

    it "425c works" do
      transformer = transform_source(test_425c)
      expect(transformer.step.search_date).to eq("2010")
    end

    it "425b and 425c works" do
      transformer = transform_source(test_425b_and_425c)
      expect(transformer.step.search_date).to eq("2000")
    end
  end

private

  def transform_source(source)
    transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::DateOfPublication,
      source,
      Metacrunch::SNR.new
    )
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
