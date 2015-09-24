describe Metacrunch::UBPB::Transformations::MAB2SNR::IsSuperorder do

  it "Default is false" do
    result = mab2snr(mab_builder) # empty mab
    expect(result.first_value("control/is_superorder")).to be(false)
  end

  it "Is superorder if 051(0) is 'n'" do
    result = mab2snr(test_mab("051", "n"))
    expect(result.first_value("control/is_superorder")).to be(true)
  end

  it "Is superorder if 051(0) is 't'" do
    result = mab2snr(test_mab("051", "t"))
    expect(result.first_value("control/is_superorder")).to be(true)
  end

  it "Is superorder if 052(0) is 'p'" do
    result = mab2snr(test_mab("052", "p"))
    expect(result.first_value("control/is_superorder")).to be(true)
  end

  it "Is superorder if 052(0) is 'r'" do
    result = mab2snr(test_mab("052", "r"))
    expect(result.first_value("control/is_superorder")).to be(true)
  end

  it "Is superorder if 052(0) is 'z'" do
    result = mab2snr(test_mab("052", "z"))
    expect(result.first_value("control/is_superorder")).to be(true)
  end

private

  def test_mab(field, value)
    mab_builder do
      controlfield(field, "#{value}||||")
    end
  end

end
