describe Metacrunch::UBPB::Transformations::MAB2SNR::TitleId do

  it "TXT works" do
    mab = mab_builder do
      datafield("001", ind2: "1") { subfield("a", "123456789") }
    end

    result = mab2snr(mab)
    expect(result.first_value("control/title_id")).to eq("123456789")
  end

end
