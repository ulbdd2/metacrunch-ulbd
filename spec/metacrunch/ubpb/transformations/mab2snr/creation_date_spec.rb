describe Metacrunch::UBPB::Transformations::MAB2SNR::CreationDate do

  it "Creation_date should be 20070905" do
    mab = mab_builder do
      datafield("LOC", ind1: " ", ind2: " ") { subfield("k", "20070905") }
      datafield("LOC", ind1: " ", ind2: " ") { subfield("k", "20070906") }
    end

    result = mab2snr(mab)
    expect(result.first_value("control/creation_date")).to eq("20070905")
  end

end
