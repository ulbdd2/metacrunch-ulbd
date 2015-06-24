describe Metacrunch::UBPB::Transformations::MAB2SNR::DateOfPublication do

  it "425a works" do
    mab = mab_builder do
      datafield("425", ind1: "a", ind2: "1") { subfield("a", "1998") }
    end
    result = mab2snr(mab)

    expect(result.first_value("display/date_of_publication")).to eq("1998")
    expect(result.first_value("search/date_of_publication")).to eq("1998")
    expect(result.first_value("sort/date_of_publication")).to eq("1998")
  end

  it "425p works" do
    mab = mab_builder do
      datafield("425", ind1: "p", ind2: "1") { subfield("a", "1999") }
    end
    result = mab2snr(mab)

    expect(result.first_value("display/date_of_publication")).to eq("1999")
    expect(result.first_value("search/date_of_publication")).to eq("1999")
    expect(result.first_value("sort/date_of_publication")).to eq("1999")
  end

  it "595 works and superseeds all other dates" do
    mab = mab_builder do
      datafield("425", ind1: "b", ind2: "1") { subfield("a", "1998") }
      datafield("595", ind1: " ", ind2: " ") { subfield("a", "1999") }
    end
    result = mab2snr(mab)

    expect(result.first_value("display/date_of_publication")).to eq("1999")
    expect(result.first_value("search/date_of_publication")).to eq("1999")
    expect(result.first_value("sort/date_of_publication")).to eq("1999")
  end

  it "425b works" do
    mab = mab_builder do
      superorder!
      datafield("425", ind1: "b", ind2: "1") { subfield("a", "2000") }
    end
    result = mab2snr(mab)

    expect(result.first_value("display/date_of_publication")).to eq("2000 –")
    expect(result.first_value("search/date_of_publication")).to eq("2000")
    expect(result.first_value("sort/date_of_publication")).to eq("2000")
  end

  it "425c works" do
    mab = mab_builder do
      superorder!
      datafield("425", ind1: "c", ind2: "1") { subfield("a", "2010") }
    end
    result = mab2snr(mab)

    expect(result.first_value("display/date_of_publication")).to eq("– 2010")
    expect(result.first_value("search/date_of_publication")).to eq("2010")
    expect(result.first_value("sort/date_of_publication")).to eq("2010")
  end

  it "425b and 425c works" do
    mab = mab_builder do
      superorder!
      datafield("425", ind1: "b", ind2: "1") { subfield("a", "2000") }
      datafield("425", ind1: "c", ind2: "1") { subfield("a", "2010") }
    end
    result = mab2snr(mab)

    expect(result.first_value("display/date_of_publication")).to eq("2000 – 2010")
    expect(result.first_value("search/date_of_publication")).to eq("2000")
    expect(result.first_value("sort/date_of_publication")).to eq("2000")
  end

end
