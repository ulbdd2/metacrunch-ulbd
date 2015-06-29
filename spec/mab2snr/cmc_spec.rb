describe Metacrunch::UBPB::Transformations::MAB2SNR::CMC do

  context "Carrier" do
    it "Default is zu => unspecified" do
      test_050({}, "zu")
    end

    context "Druckschrift" do
      it "0(a) => zu" do
        test_050({"0": "a"}, "zu")
      end
    end

    context "Handschrift" do
      it "1(a) => zu" do
        test_050({"1": "a"}, "zu")
      end
    end

    context "Mikroform" do
      it "3(a) => he" do
        test_050({"3": "a"}, "he")
      end

      it "3(b) => he" do
        test_050({"3": "b"}, "he")
      end

      it "3(c) => he" do
        test_050({"3": "c"}, "he")
      end
    end

    context "Blindenschriftträger" do
      it "4(a) => zu" do
        test_050({"4": "a"}, "zu")
      end
    end

    context "AV-Medien" do
      it "5(a), 6(a) => sd" do
        test_050({"5": "a", "6": "a"}, "sd")
      end

      it "5(a), 6(b) => sd" do
        test_050({"5": "a", "6": "b"}, "sd")
      end

      it "5(a), 6(c) => st" do
        test_050({"5": "a", "6": "c"}, "st")
      end

      it "5(a), 6(d) => ss" do
        test_050({"5": "a", "6": "d"}, "ss")
      end

      it "5(a), 6(e) => ss" do
        test_050({"5": "a", "6": "e"}, "ss")
      end

      it "5(a), 6(f) => ss" do
        test_050({"5": "a", "6": "f"}, "ss")
      end

      it "5(a), 6(g) => ss" do
        test_050({"5": "a", "6": "g"}, "ss")
      end

      it "5(a), 6(h) => sg" do
        test_050({"5": "a", "6": "h"}, "sg")
      end

      it "5(a), 6(i) => sz" do
        test_050({"5": "a", "6": "i"}, "sz")
      end

      it "5(a), 6(j) => sd" do
        test_050({"5": "a", "6": "j"}, "sd")
      end

      it "5(a), 6(k) => se" do
        test_050({"5": "a", "6": "k"}, "se")
      end

      it "5(a), 6(l) => sq" do
        test_050({"5": "a", "6": "l"}, "sq")
      end

      it "5(a), 6(m) => si" do
        test_050({"5": "a", "6": "m"}, "si")
      end

      it "5(a), 6(n) => sz" do
        test_050({"5": "a", "6": "n"}, "sz")
      end

      it "5(b), 6(a) => mr" do
        test_050({"5": "b", "6": "a"}, "mr")
      end

      it "5(b), 6(b) => mc" do
        test_050({"5": "b", "6": "b"}, "mc")
      end

      it "5(b), 6(c) => mf" do
        test_050({"5": "b", "6": "c"}, "mf")
      end

      it "5(b), 6(d) => mz" do
        test_050({"5": "b", "6": "d"}, "mz")
      end

      it "5(b), 6(e) => gf" do
        test_050({"5": "b", "6": "e"}, "gf")
      end

      it "5(b), 6(f) => gc" do
        test_050({"5": "b", "6": "f"}, "gc")
      end

      it "5(b), 6(g) => mo" do
        test_050({"5": "b", "6": "g"}, "mo")
      end

      it "5(b), 6(h) => mz" do
        test_050({"5": "b", "6": "h"}, "mz")
      end

      it "5(b), 6(i) => gs" do
        test_050({"5": "b", "6": "i"}, "gs")
      end

      it "5(b), 6(j) => gt" do
        test_050({"5": "b", "6": "j"}, "gt")
      end

      it "5(b), 6(k) => gt" do
        test_050({"5": "b", "6": "j"}, "gt")
      end

      it "5(c), 6(a) => vf" do
        test_050({"5": "c", "6": "a"}, "vf")
      end

      it "5(c), 6(b) => vc" do
        test_050({"5": "c", "6": "b"}, "vc")
      end

      it "5(c), 6(c) => vr" do
        test_050({"5": "c", "6": "c"}, "vr")
      end

      it "5(c), 6(d) => vd" do
        test_050({"5": "c", "6": "d"}, "vd")
      end

      it "5(c), 6(e) => vz" do
        test_050({"5": "c", "6": "e"}, "vz")
      end

      it "5(d), 6(a) => zu" do
        test_050({"5": "d", "6": "a"}, "zu")
      end

      it "5(d), 6(b) => zu" do
        test_050({"5": "d", "6": "b"}, "zu")
      end

      it "5(d), 6(c) => zu" do
        test_050({"5": "d", "6": "c"}, "zu")
      end

      it "5(u), 6(u) => zu" do
        test_050({"5": "u", "6": "u"}, "zu")
      end

      it "5(y), 6(y) => zu" do
        test_050({"5": "y", "6": "y"}, "zu")
      end

      it "5(z), 6(z) => zu" do
        test_050({"5": "z", "6": "z"}, "zu")
      end
    end

    context "Medienkombinationen" do
      it "7(a) => zu" do
        test_050({"7": "a"}, "zu")
      end
    end

    context "Elektronische Ressource" do
      it "8(a) => cz" do
        test_050({"8": "a"}, "cz")
      end

      it "8(b) => cd" do
        test_050({"8": "b"}, "cd")
      end

      it "8(c) => cf" do
        test_050({"8": "c"}, "cf")
      end

      it "8(d) => cd" do
        test_050({"8": "d"}, "cd")
      end

      it "8(e) => ck" do
        test_050({"8": "e"}, "ck")
      end

      it "8(f) => ch" do
        test_050({"8": "f"}, "ch")
      end

      it "8(g) => cr" do
        test_050({"8": "g"}, "cr")
      end

      it "8(z) => cz" do
        test_050({"8": "z"}, "cz")
      end
    end

    context "Spiele" do
      it "9(a) => zu" do
        test_050({"9": "a"}, "zu")
      end
    end

    context "Landkarten" do
      it "10(a) => zu" do
        test_050({"10": "a"}, "no")
      end
    end
  end

private

  def test_050(mapping, expected_value)
    values = mapping.inject(Array.new(14)){|a, (k, v)| a[k.to_s.to_i] = v ; a}
    mab    = mab_builder { controlfield("050", values) }
    result = mab2snr(mab)
    expect(result.first_value("control/cmc")[:carrier]).to eq(expected_value)
  end

end
