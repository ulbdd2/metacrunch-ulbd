describe Metacrunch::UBPB::Transformations::MAB2SNR::Title do

  context "Search" do
    it "all fields work" do
      all_fields.each do |field|
        field_s = sprintf("%03d", field)
        mab     = mab_builder { datafield(field_s, ind2: "1") { subfield("a", "SOME VALUE")} }
        result  = perform(mab)
        expect(result[:search]).not_to be_empty
        expect(result[:search][0]).to eq("SOME VALUE")

        mab     = mab_builder { datafield(field_s, ind2: "2") { subfield("a", "SOME VALUE")} }
        result  = perform(mab)
        expect(result[:search]).not_to be_empty
        expect(result[:search][0]).to eq("SOME VALUE")
      end
    end

    it "removes non-sort characters" do
      mab     = mab_builder { datafield("331", ind2: "1") { subfield("a", "<<SOME>> VALUE")} }
      result  = perform(mab)
      expect(result[:search][0]).to eq("SOME VALUE")
    end
  end

  context "Display & Sort" do
    it "Returns 310 if 360 is present for ind2=1" do
      mab = mab_builder do
        datafield("310", ind2: "1") { subfield("a", "FOO") }
        datafield("360", ind2: "1") { subfield("a", "BAR") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("FOO")
    end

    it "Returns 310 if 360 is present for ind2=2" do
      mab = mab_builder do
        controlfield("051", "n||||") # superorder
        datafield("310", ind2: "2") { subfield("a", "FOO") }
        datafield("360", ind2: "2") { subfield("a", "BAR") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("FOO")
    end

    it "Returns 331 ind2=1 if present" do
      mab = mab_builder do
        datafield("331", ind2: "1") { subfield("a", "FOO") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("FOO")
    end

    it "Returns 331 ind2=2 if present" do
      mab = mab_builder do
        datafield("331", ind2: "2") { subfield("a", "FOO") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("FOO")
    end

    it "Returns 089 ind2=1 if present" do
      mab = mab_builder do
        datafield("089", ind2: "1") { subfield("a", "FOO") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("FOO")
    end

    it "310/360 has precedence over 331_1, 331_2 and 089_1" do
      mab = mab_builder do
        datafield("089", ind2: "1") { subfield("a", "089_1") }
        datafield("310", ind2: "1") { subfield("a", "310_1") }
        datafield("331", ind2: "1") { subfield("a", "331_1") }
        datafield("331", ind2: "2") { subfield("a", "331_2") }
        datafield("360", ind2: "1") { subfield("a", "360_1") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("310_1")
    end

    it "331_1 has precedence over 331_2 and 089_1" do
      mab = mab_builder do
        datafield("089", ind2: "1") { subfield("a", "089_1") }
        datafield("331", ind2: "1") { subfield("a", "331_1") }
        datafield("331", ind2: "2") { subfield("a", "331_2") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("331_1")
    end

    it "331_2 has precedence over 089_1" do
      mab = mab_builder do
        datafield("089", ind2: "1") { subfield("a", "089_1") }
        datafield("331", ind2: "2") { subfield("a", "331_2") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("331_2")
    end

    it "334_1 gets appendend if present" do
      mab = mab_builder do
        datafield("331", ind2: "1") { subfield("a", "331_1") }
        datafield("334", ind2: "1") { subfield("a", "334_1") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("331_1 [334_1]")
    end

    it "334_2 gets appendend if present" do
      mab = mab_builder do
        datafield("331", ind2: "1") { subfield("a", "331_1") }
        datafield("334", ind2: "2") { subfield("a", "334_2") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("331_1 [334_2]")
    end

    it "334_1 has precedence over 334_2" do
      mab = mab_builder do
        datafield("331", ind2: "1") { subfield("a", "331_1") }
        datafield("334", ind2: "1") { subfield("a", "334_1") }
        datafield("334", ind2: "2") { subfield("a", "334_2") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("331_1 [334_1]")
    end

    it "335_1 gets appendend if present" do
      mab = mab_builder do
        datafield("331", ind2: "1") { subfield("a", "331_1") }
        datafield("335", ind2: "1") { subfield("a", "335_1") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("331_1 : 335_1")
    end

    it "361_1 gets appendend if present" do
      mab = mab_builder do
        datafield("331", ind2: "1") { subfield("a", "331_1") }
        datafield("361", ind2: "1") { subfield("a", "361_1") }
      end

      result = perform(mab)
      expect(result[:display]).to eq("331_1. 361_1")
    end

    it "Removes non-sort characters" do
      mab     = mab_builder { datafield("331", ind2: "1") { subfield("a", "<<SOME>> VALUE")} }
      result  = perform(mab)
      expect(result[:display]).to eq("SOME VALUE")
    end
  end

  context "Sort" do
    it "Removes words wrapped in non-sort characters" do
      mab     = mab_builder { datafield("331", ind2: "1") { subfield("a", "<<SOME>> VALUE")} }
      result  = perform(mab)
      expect(result[:sort]).to eq("VALUE")
    end
  end

private

  def perform(source)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::Title,
      source,
      Metacrunch::SNR.new
    )

    search  = transformer.target.values("search/title")
    display = transformer.target.values("display/title").first
    sort    = transformer.target.values("sort/title").first

    {
      transformer: transformer,
      search: search,
      display: display,
      sort: sort
    }
  end

  def all_fields
    fields = 89, 304, 310, 331, 333, 334, 335, *(340..355), 360, 361,
      365, 370, 376, *(451..491).step(10).to_a, 502, 504, 505, 517,
      *(526..534), 590, 592, 597, 621, 624, 627, 630, 633
  end

end
