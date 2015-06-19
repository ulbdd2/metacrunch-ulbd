describe Metacrunch::UBPB::Transformations::MAB2SNR::Status do

  it "defaut state is A" do
    result = perform(test_default)
    expect(result[:status]).to eq("A")
  end

  # gelöscht
  it "state is D if LDR(6) is 'd'" do
    result = perform(test_ldr)
    expect(result[:status]).to eq("D")
  end

  # ausgesondert über 078
  it "state is D if 078r is 'aus'" do
    result = perform(test_078)
    expect(result[:status]).to eq("D")
  end

  # Standort Detmold
  it "state is D if LOCn is '50'" do
    result = perform(test_loc)
    expect(result[:status]).to eq("D")
  end

  # Interimsaufnahmen
  it "state is D if 537a is 'interimsaufnahme'" do
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::Status,
      source,
      Metacrunch::SNR.new
    )

    status = transformer.target.values("control/status").first

    {
      transformer: transformer,
      status: status
    }
  end

  def test_default
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
      </record>
    XML
  end

  def test_ldr
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <controlfield tag="LDR">00000d00000</controlfield>
      </record>
    XML
  end

  def test_078
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="078" ind1="r" ind2=" ">
          <subfield code="a">aus</subfield>
        </datafield>
      </record>
    XML
  end

  def test_loc
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="LOC" ind1=" " ind2=" ">
          <subfield code="n">50</subfield>
        </datafield>
      </record>
    XML
  end

  def test_537
    Metacrunch::Mab2::Document.from_aleph_mab_xml <<-XML
      <record>
        <datafield tag="LOC" ind1="-" ind2=" ">
          <subfield code="a">Interimsaufnahme</subfield>
        </datafield>
      </record>
    XML
  end

end
