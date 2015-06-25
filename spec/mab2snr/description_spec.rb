describe Metacrunch::UBPB::Transformations::MAB2SNR::Description do

  it "All relevant fields work" do
    fields = 405, 522, 523, *501..519, 536, 537
     fields.each do |field|
      mab = mab_builder do
        datafield(field.to_s, ind1: "-", ind2: "1") do
          subfield("a", "DESCRIPTION")
          subfield("p", "PREFIX")
        end
      end

      result = mab2snr(mab)
      expect(result.first_value("display/description")).to eq("PREFIX: DESCRIPTION")
      expect(result.first_value("search/description")).to eq("PREFIX: DESCRIPTION")
    end
  end

  it "Fields can have a prefix" do
    mab = mab_builder do
      datafield("405", ind1: "-", ind2: "1") { subfield("a", "DESCRIPTION") }
    end

    result = mab2snr(mab)
    expect(result.first_value("display/description")).to eq("DESCRIPTION")
    expect(result.first_value("search/description")).to eq("DESCRIPTION")

    mab = mab_builder do
      datafield("405", ind1: "-", ind2: "1") do
        subfield("a", "DESCRIPTION")
        subfield("p", "PREFIX")
      end
    end

    result = mab2snr(mab)
    expect(result.first_value("display/description")).to eq("PREFIX: DESCRIPTION")
    expect(result.first_value("search/description")).to eq("PREFIX: DESCRIPTION")
  end

  it "537 will be ignored for journals" do
    mab = mab_builder do
      journal!
      datafield("537", ind1: "-", ind2: "1") do
        subfield("a", "DESCRIPTION")
        subfield("p", "PREFIX")
      end
    end

    result = mab2snr(mab)
    expect(result.first_value("display/description")).to be_nil
    expect(result.first_value("search/description")).to be_nil
  end

end
