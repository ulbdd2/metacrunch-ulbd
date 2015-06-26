describe Metacrunch::UBPB::Transformations::MAB2SNR::Toc do

  it "TXT works" do
    mab = mab_builder do
      datafield("TXT") { subfield("a", "SOME TOC CONTENT") }
      datafield("TXT") { subfield("a", "MORE TOC CONTENT") }
    end

    result = mab2snr(mab)
    expect(result.first_value("search/toc")).to eq("SOME TOC CONTENT MORE TOC CONTENT")
  end

end
