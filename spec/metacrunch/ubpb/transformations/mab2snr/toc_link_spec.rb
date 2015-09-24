describe Metacrunch::UBPB::Transformations::MAB2SNR::TocLink do

  it "Ignores 655 resource links" do
    mab = mab_builder do
      datafield("655") do
        subfield("u", "http://example.com")
      end
    end

    result = mab2snr(mab)
    expect(result.values("link/toc")).to be_empty
  end

  it "Finds HBZ TOC" do
    mab = mab_builder do
      datafield("655", ind1: " ", ind2: " ") do
        subfield("u", "http://example.com")
        subfield("y", "SOME LABEL")
        subfield("3", "Inhaltsverzeichnis")
      end
    end

    result = mab2snr(mab)
    expect(result.first_value("link/toc")[:url]).to eq("http://example.com")
  end

  it "Finds BVB TOC" do
    mab = mab_builder do
      datafield("655", ind1: " ", ind2: " ") do
        subfield("u", "http://example.com")
        subfield("y", "SOME LABEL")
        subfield("z", "Inhaltsverzeichnis")
      end
    end

    result = mab2snr(mab)
    expect(result.first_value("link/toc")[:url]).to eq("http://example.com")
  end

  it "Finds Adam TOC" do
    mab = mab_builder do
      datafield("655", ind1: " ", ind2: " ") do
        subfield("u", "http://example.com")
        subfield("y", "SOME LABEL")
        subfield("t", "VIEW")
      end
    end

    result = mab2snr(mab)
    expect(result.first_value("link/toc")[:url]).to eq("http://example.com")
  end

end
