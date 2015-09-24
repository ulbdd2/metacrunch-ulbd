describe Metacrunch::UBPB::Transformations::MAB2SNR::Status do

  it "Default state is A" do
    mab = mab_builder # empty mab doc

    result = mab2snr(mab)
    expect(result.first_value("control/status")).to eq("A")
  end

  # gelöscht
  it "State is D if LDR(6) is 'd'" do
    mab = mab_builder do
      controlfield("LDR", "00000d00000")
    end

    result = mab2snr(mab)
    expect(result.first_value("control/status")).to eq("D")
  end

  # ausgesondert über 078
  it "State is D if 078r is 'aus'" do
    mab = mab_builder do
      datafield("078", ind1: "r") { subfield("a", "aus") }
    end

    result = mab2snr(mab)
    expect(result.first_value("control/status")).to eq("D")
  end

  # Standort Detmold
  it "State is D if LOCn is '50'" do
    mab = mab_builder do
      datafield("LOC") { subfield("n", "50") }
    end

    result = mab2snr(mab)
    expect(result.first_value("control/status")).to eq("D")
  end

  # Interimsaufnahmen
  it "State is D if 537a is 'interimsaufnahme'" do
    mab = mab_builder do
      datafield("537", ind1: " ", ind2: "1") { subfield("a", "interimsaufnahme") }
    end

    result = mab2snr(mab)
    expect(result.first_value("control/status")).to eq("D")
  end

end
