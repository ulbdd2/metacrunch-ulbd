describe (field_name = "search/signature") do
  [
    # Zeitschriftensignaturen
    ["PAD01.000321365.PRIMO.xml", ["34K12", "34 K 12", "P10/34K12", "P 10/34 K 12"]],
    ["PAD01.000636652.PRIMO.xml", ["P10/34M3", "P 10/34 M 3", "34M3", "34 M 3"]],
    ["PAD01.000857994.PRIMO.xml", ["34T26", "34 T 26", "P10/34T26", "P 10/34 T 26"]],
    ["PAD01.000452919.PRIMO.xml", ["P02/49S105", "P 02/49 S 105", "49S105", "49 S 105"]],

    ["PAD01.000859176.PRIMO.xml", "KDVD1105"],
    ["PAD01.000969442.PRIMO.xml", ["TWR12765+4", "TWR12765", "TWR12765+1", "TWR12765+2", "TWR12765+3"]],

    ["PAD01.000765779.PRIMO.xml", ["34T24", "34 T 24", "P10/34T24", "P 10/34 T 24"]],
    ["PAD01.000869906.PRIMO.xml", ["34T24", "34 T 24", "P10/34T24", "P 10/34 T 24"]],
    ["PAD01.001414237.PRIMO.xml", ["34T24", "34 T 24", "P10/34T24", "P 10/34 T 24"]],

    # Signatur mit anhängiger Bandzählung
    ["PAD01.000161445.PRIMO.xml", ["KXW4113-80/81", "KXW4113-80", "KXW4113"]],
    ["PAD01.001006945.PRIMO.xml", ["LKL2468-14", "LKL2468"]],

    # UV183
    ["PAD01.000318290.PRIMO.xml", ["43G18", "43 G 18", "P96/43G18", "P 96/43 G 18", "P02/43G18", "P 02/43 G 18", "P30/43G18", "P 30/43 G 18"]], # Geographie heute
    ["PAD01.000897969.PRIMO.xml", ["40P8", "40 P 8", "P30/40P8", "P 30/40 P 8", "P96/40P8", "P 96/40 P 8"]],                                    # Praxis Geschichte
    ["PAD01.000998195.PRIMO.xml", ["40P8", "40 P 8", "P96/40P8", "P 96/40 P 8"]],                                                               # Praxis Geschichte [Elektronische Ressource]
    ["PAD01.001518782.PRIMO.xml", ["43G18", "43 G 18", "P30/43G18", "P 30/43 G 18"]],                                                           # Geographie heute

    # missing subfield 0
    ["PAD01.000695094.PRIMO.xml", ["P30/49P30", "P 30/49 P 30", "49P30", "49 P 30"]]
  ]
  .each do |_filename, _expected_value|
    context "for #{_filename}" do
      subject do
        perform_step(Metacrunch::UBPB::Transformations::MAB2SNR::Signature, read_mab_file(_filename)).target.values(field_name)
      end

      it { is_expected.to eq([_expected_value].flatten(1)) }
    end
  end
end
