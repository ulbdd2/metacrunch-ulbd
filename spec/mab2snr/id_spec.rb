describe Metacrunch::UBPB::Transformations::MAB2SNR::Id do

  it "works" do
    mab = mab_builder {} # empty

    result = mab2snr(mab, {source_id: "123456789"})
    expect(result.first_value("control/id")).to eq("123456789")
  end

end
