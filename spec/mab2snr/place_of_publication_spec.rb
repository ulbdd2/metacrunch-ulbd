describe Metacrunch::UBPB::Transformations::MAB2SNR::PlaceOfPublication do

  it "410 ind2=1 works" do
    mab = mab_builder do
      datafield("410", ind1: "-", ind2: "1") { subfield("a", "SOME PLACE") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/place_of_publication")).to eq("SOME PLACE")
    expect(result.first_value("search/place_of_publication")).to eq("SOME PLACE")
  end

  it "410 ind2=2 works" do
    mab = mab_builder do
      datafield("410", ind1: "-", ind2: "2") { subfield("a", "SOME PLACE") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/place_of_publication")).to eq("SOME PLACE")
    expect(result.first_value("search/place_of_publication")).to eq("SOME PLACE")
  end

  it "415 ind2=1 works" do
    mab = mab_builder do
      datafield("415", ind1: "-", ind2: "1") { subfield("a", "SOME PLACE") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/place_of_publication")).to eq("SOME PLACE")
    expect(result.first_value("search/place_of_publication")).to eq("SOME PLACE")
  end

  it "415 ind2=1 works" do
    mab = mab_builder do
      datafield("415", ind1: "-", ind2: "2") { subfield("a", "SOME PLACE") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/place_of_publication")).to eq("SOME PLACE")
    expect(result.first_value("search/place_of_publication")).to eq("SOME PLACE")
  end

  it "410 and 415 works" do
    mab = mab_builder do
      datafield("410", ind1: "-", ind2: "1") { subfield("a", "SOME PLACE") }
      datafield("415", ind1: "-", ind2: "1") { subfield("a", "ANOTHER PLACE") }
    end

    result = mab2snr(mab)
    expect(result.values("display/place_of_publication")[0]).to eq("SOME PLACE")
    expect(result.values("display/place_of_publication")[1]).to eq("ANOTHER PLACE")
    expect(result.values("search/place_of_publication")[0]).to eq("SOME PLACE")
    expect(result.values("search/place_of_publication")[1]).to eq("ANOTHER PLACE")
  end

end
