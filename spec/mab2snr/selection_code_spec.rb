describe Metacrunch::UBPB::Transformations::MAB2SNR::SelectionCode do

  it "078 ind1=e works" do
    mab = mab_builder do
      datafield("078", ind1: "e", ind2: " ") { subfield("a", "abc") }
    end

    result = mab2snr(mab)
    expect(result.first_value("control/selection_code")).to eq("abc")
  end

  it "078 ind1=r works" do
    mab = mab_builder do
      datafield("078", ind1: "r", ind2: " ") { subfield("a", "xyz") }
    end

    result = mab2snr(mab)
    expect(result.first_value("control/selection_code")).to eq("xyz")
  end

end
