describe Metacrunch::UBPB::Transformations::MAB2SNR::ResourceLink do

  it "655 works" do
    mab = mab_builder do
      datafield("655", ind1: " ", ind2: " ") do
        subfield("u", "http://example.com")
        subfield("y", "SOME LABEL")
      end
    end

    result = mab2snr(mab)
    expect(result.first_value("link/resource")[:url]).to eq("http://example.com")
    expect(result.first_value("link/resource")[:label]).to eq("SOME LABEL")
  end

  it "label is optional" do
    mab = mab_builder do
      datafield("655", ind1: " ", ind2: " ") do
        subfield("u", "http://example.com")
      end
    end

    result = mab2snr(mab)
    expect(result.first_value("link/resource")[:url]).to eq("http://example.com")
    expect(result.first_value("link/resource")[:label]).to be_nil
  end

  it "ignores HBZ TOC" do
    mab = mab_builder do
      datafield("655", ind1: " ", ind2: " ") do
        subfield("u", "http://example.com")
        subfield("y", "SOME LABEL")
        subfield("3", "Inhaltsverzeichnis")
      end
    end

    result = mab2snr(mab)
    expect(result.values("link/resource")).to be_empty
  end

  it "ignores BVB TOC" do
    mab = mab_builder do
      datafield("655", ind1: " ", ind2: " ") do
        subfield("u", "http://example.com")
        subfield("y", "SOME LABEL")
        subfield("z", "Inhaltsverzeichnis")
      end
    end

    result = mab2snr(mab)
    expect(result.values("link/resource")).to be_empty
  end

  it "ignores Adam TOC" do
    mab = mab_builder do
      datafield("655", ind1: " ", ind2: " ") do
        subfield("u", "http://example.com")
        subfield("y", "SOME LABEL")
        subfield("t", "VIEW")
      end
    end

    result = mab2snr(mab)
    expect(result.values("link/resource")).to be_empty
  end

end
