describe Metacrunch::UBPB::Transformations::MAB2SNR::VolumeCount do

  it "456, 466, 476, 486, 496 works" do
    ["456", "466", "476", "486", "496"].each do |field|
      mab = mab_builder do
        datafield(field, ind2: "1") { subfield("a", "2") }
      end

      result = mab2snr(mab)
      expect(result.first_value("control/volume_count")).to eq(2)
    end
  end

  it "Lower fields have precedence over hight fields" do
    mab = mab_builder do
      datafield("456", ind2: "1") { subfield("a", "1") }
      datafield("496", ind2: "1") { subfield("a", "2") }
    end

    result = mab2snr(mab)
    expect(result.first_value("control/volume_count")).to eq(1)
  end

end
