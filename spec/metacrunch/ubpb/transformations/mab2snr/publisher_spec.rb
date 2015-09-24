describe Metacrunch::UBPB::Transformations::MAB2SNR::Publisher do

  it "412 ind2=1 works" do
    mab = mab_builder do
      datafield("412", ind1: "-", ind2: "1") { subfield("a", "SOME PUBLISHER") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/publisher")).to eq("SOME PUBLISHER")
    expect(result.first_value("search/publisher")).to eq("SOME PUBLISHER")
  end

  it "412 ind2=2 works" do
    mab = mab_builder do
      datafield("412", ind1: "-", ind2: "2") { subfield("a", "SOME PUBLISHER") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/publisher")).to eq("SOME PUBLISHER")
    expect(result.first_value("search/publisher")).to eq("SOME PUBLISHER")
  end

  it "417 ind2=1 works" do
    mab = mab_builder do
      datafield("417", ind1: "-", ind2: "1") { subfield("a", "SOME PUBLISHER") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/publisher")).to eq("SOME PUBLISHER")
    expect(result.first_value("search/publisher")).to eq("SOME PUBLISHER")
  end

  it "417 ind2=2 works" do
    mab = mab_builder do
      datafield("417", ind1: "-", ind2: "2") { subfield("a", "SOME PUBLISHER") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/publisher")).to eq("SOME PUBLISHER")
    expect(result.first_value("search/publisher")).to eq("SOME PUBLISHER")
  end

  it "412_1 and 417_1 works" do
    mab = mab_builder do
      datafield("412", ind1: "-", ind2: "1") { subfield("a", "SOME PUBLISHER") }
      datafield("417", ind1: "-", ind2: "1") { subfield("a", "ANOTHER PUBLISHER") }
    end

    result = mab2snr(mab)
    expect(result.values("display/publisher")[0]).to eq("SOME PUBLISHER")
    expect(result.values("display/publisher")[1]).to eq("ANOTHER PUBLISHER")
    expect(result.values("search/publisher")[0]).to eq("SOME PUBLISHER")
    expect(result.values("search/publisher")[1]).to eq("ANOTHER PUBLISHER")
  end

end
