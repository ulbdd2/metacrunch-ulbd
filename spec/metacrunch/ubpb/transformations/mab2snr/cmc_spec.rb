describe Metacrunch::UBPB::Transformations::MAB2SNR::CMC do

  context "Media" do
    it "Default is z => unspecified" do
      perform_test(:media, {}, "z")
    end
  end

  context "Content" do
    it "Default is zzz => unspecified" do
      perform_test(:content, {}, "zzz")
    end
  end

  context "Carrier" do
    it "Default is zu => unspecified" do
      perform_test(:carrier, {}, "zu")
    end

    context "Druckschrift" do
      it "0(a) => nc" do
        perform_test(:carrier, {"0": "a"}, "nc")
      end
    end

    context "Handschrift" do
      it "1(a) => nc" do
        perform_test(:carrier, {"1": "a"}, "nc")
      end
    end

    context "Mikroform" do
      it "3(a) => he" do
        perform_test(:carrier, {"3": "a"}, "he")
      end

      it "3(b) => he" do
        perform_test(:carrier, {"3": "b"}, "he")
      end

      it "3(c) => he" do
        perform_test(:carrier, {"3": "c"}, "he")
      end
    end

    context "Blindenschriftträger" do
      it "4(a) => zu" do
        perform_test(:carrier, {"4": "a"}, "zu")
      end
    end

    context "AV-Medien" do
      it "5(a), 6(a) => sd" do
        perform_test(:carrier, {"5": "a", "6": "a"}, "sd")
      end

      it "5(a), 6(b) => sd" do
        perform_test(:carrier, {"5": "a", "6": "b"}, "sd")
      end

      it "5(a), 6(c) => st" do
        perform_test(:carrier, {"5": "a", "6": "c"}, "st")
      end

      it "5(a), 6(d) => ss" do
        perform_test(:carrier, {"5": "a", "6": "d"}, "ss")
      end

      it "5(a), 6(e) => ss" do
        perform_test(:carrier, {"5": "a", "6": "e"}, "ss")
      end

      it "5(a), 6(f) => ss" do
        perform_test(:carrier, {"5": "a", "6": "f"}, "ss")
      end

      it "5(a), 6(g) => ss" do
        perform_test(:carrier, {"5": "a", "6": "g"}, "ss")
      end

      it "5(a), 6(h) => sg" do
        perform_test(:carrier, {"5": "a", "6": "h"}, "sg")
      end

      it "5(a), 6(i) => sz" do
        perform_test(:carrier, {"5": "a", "6": "i"}, "sz")
      end

      it "5(a), 6(j) => sd" do
        perform_test(:carrier, {"5": "a", "6": "j"}, "sd")
      end

      it "5(a), 6(k) => se" do
        perform_test(:carrier, {"5": "a", "6": "k"}, "se")
      end

      it "5(a), 6(l) => sq" do
        perform_test(:carrier, {"5": "a", "6": "l"}, "sq")
      end

      it "5(a), 6(m) => si" do
        perform_test(:carrier, {"5": "a", "6": "m"}, "si")
      end

      it "5(a), 6(n) => sz" do
        perform_test(:carrier, {"5": "a", "6": "n"}, "sz")
      end

      it "5(b), 6(a) => mr" do
        perform_test(:carrier, {"5": "b", "6": "a"}, "mr")
      end

      it "5(b), 6(b) => mc" do
        perform_test(:carrier, {"5": "b", "6": "b"}, "mc")
      end

      it "5(b), 6(c) => mf" do
        perform_test(:carrier, {"5": "b", "6": "c"}, "mf")
      end

      it "5(b), 6(d) => mz" do
        perform_test(:carrier, {"5": "b", "6": "d"}, "mz")
      end

      it "5(b), 6(e) => gf" do
        perform_test(:carrier, {"5": "b", "6": "e"}, "gf")
      end

      it "5(b), 6(f) => gc" do
        perform_test(:carrier, {"5": "b", "6": "f"}, "gc")
      end

      it "5(b), 6(g) => mo" do
        perform_test(:carrier, {"5": "b", "6": "g"}, "mo")
      end

      it "5(b), 6(h) => mz" do
        perform_test(:carrier, {"5": "b", "6": "h"}, "mz")
      end

      it "5(b), 6(i) => gs" do
        perform_test(:carrier, {"5": "b", "6": "i"}, "gs")
      end

      it "5(b), 6(j) => gt" do
        perform_test(:carrier, {"5": "b", "6": "j"}, "gt")
      end

      it "5(b), 6(k) => gt" do
        perform_test(:carrier, {"5": "b", "6": "j"}, "gt")
      end

      it "5(c), 6(a) => vf" do
        perform_test(:carrier, {"5": "c", "6": "a"}, "vf")
      end

      it "5(c), 6(b) => vc" do
        perform_test(:carrier, {"5": "c", "6": "b"}, "vc")
      end

      it "5(c), 6(c) => vr" do
        perform_test(:carrier, {"5": "c", "6": "c"}, "vr")
      end

      it "5(c), 6(d) => vd" do
        perform_test(:carrier, {"5": "c", "6": "d"}, "vd")
      end

      it "5(c), 6(e) => vz" do
        perform_test(:carrier, {"5": "c", "6": "e"}, "vz")
      end

      it "5(d), 6(a) => zu" do
        perform_test(:carrier, {"5": "d", "6": "a"}, "zu")
      end

      it "5(d), 6(b) => zu" do
        perform_test(:carrier, {"5": "d", "6": "b"}, "zu")
      end

      it "5(d), 6(c) => zu" do
        perform_test(:carrier, {"5": "d", "6": "c"}, "zu")
      end

      it "5(u), 6(u) => zu" do
        perform_test(:carrier, {"5": "u", "6": "u"}, "zu")
      end

      it "5(y), 6(y) => zu" do
        perform_test(:carrier, {"5": "y", "6": "y"}, "zu")
      end

      it "5(z), 6(z) => zu" do
        perform_test(:carrier, {"5": "z", "6": "z"}, "zu")
      end
    end

    context "Medienkombinationen" do
      it "7(a) => zu" do
        perform_test(:carrier, {"7": "a"}, "zu")
      end
    end

    context "Elektronische Ressource" do
      it "8(a) => cz" do
        perform_test(:carrier, {"8": "a"}, "cz")
      end

      it "8(b) => cd" do
        perform_test(:carrier, {"8": "b"}, "cd")
      end

      it "8(c) => cf" do
        perform_test(:carrier, {"8": "c"}, "cf")
      end

      it "8(d) => cd" do
        perform_test(:carrier, {"8": "d"}, "cd")
      end

      it "8(e) => ck" do
        perform_test(:carrier, {"8": "e"}, "ck")
      end

      it "8(f) => ch" do
        perform_test(:carrier, {"8": "f"}, "ch")
      end

      it "8(g) => cr" do
        perform_test(:carrier, {"8": "g"}, "cr")
      end

      it "8(z) => cz" do
        perform_test(:carrier, {"8": "z"}, "cz")
      end
    end

    context "Spiele" do
      it "9(a) => nz" do
        perform_test(:carrier, {"9": "a"}, "nz")
      end
    end

    context "Landkarten" do
      it "10(a) => zu" do
        perform_test(:carrier, {"10": "a"}, "no")
      end
    end
  end

private

  def perform_test(type, mapping, expected_value)
    values = mapping.inject(Array.new(14)){|a, (k, v)| a[k.to_s.to_i] = v ; a}
    mab    = mab_builder { controlfield("050", values) }
    result = mab2snr(mab)
    expect(result.first_value("control/cmc")[type.to_sym]).to eq(expected_value)
  end

end
