describe Metacrunch::UBPB::Transformations::MAB2SNR::Edition do

  it "403 ind2=1 works" do
    mab = mab_builder do
      datafield("403", ind1: "-", ind2: "1") { subfield("a", "2. PRINT.") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/edition")).to eq("2. PRINT.")
    expect(result.first_value("search/edition")).to eq("2. PRINT.")
    expect(result.first_value("sort/edition")).to eq(2)
  end

  it "403 ind2=1 works" do
    mab = mab_builder do
      datafield("403", ind1: "-", ind2: "2") { subfield("a", "2. PRINT.") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/edition")).to eq("2. PRINT.")
    expect(result.first_value("search/edition")).to eq("2. PRINT.")
    expect(result.first_value("sort/edition")).to eq(2)
  end

  it "407 ind2=2 works" do
    mab = mab_builder do
      datafield("403", ind1: "-", ind2: "1") { subfield("a", "2. PRINT.") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/edition")).to eq("2. PRINT.")
    expect(result.first_value("search/edition")).to eq("2. PRINT.")
    expect(result.first_value("sort/edition")).to eq(2)
  end

end
