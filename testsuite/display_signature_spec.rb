describe (field_name = "display/signature") do
  [
    # Zeitschriftensignaturen
    ["PAD01.000321365.PRIMO.xml", "P10/34k12"],
    ["PAD01.000636652.PRIMO.xml", "P10/34m3"],
    ["PAD01.000857994.PRIMO.xml", "P10/34t26"],

    ["PAD01.000765779.PRIMO.xml", "P10/34t24"],
    ["PAD01.000869906.PRIMO.xml", "P10/34t24"],
    ["PAD01.001414237.PRIMO.xml", "P10/34t24"],

    # Signaturen
    ["PAD01.000859176.PRIMO.xml", "KDVD1105"],
    ["PAD01.000969442.PRIMO.xml", "TWR12765"],

    # Signatur mit anhängiger Bandzählung
    ["PAD01.000161445.PRIMO.xml", "KXW4113-80/81"],
    ["PAD01.001006945.PRIMO.xml", "LKL2468-14"],

    # UV183
    ["PAD01.000318290.PRIMO.xml", "P30/43g18"], # Geographie heute
    ["PAD01.000897969.PRIMO.xml", "P30/40p8"],  # Praxis Geschichte
    ["PAD01.000998195.PRIMO.xml", "P96/40p8"],  # Praxis Geschichte [Elektronische Ressource]
    ["PAD01.001518782.PRIMO.xml", "P30/43g18"], # Geographie heute

    # missing subfield 0
    ["PAD01.000695094.PRIMO.xml", "P30/49p30"]
  ]
  .each do |_filename, _expected_value|
    context "for #{_filename}" do
      subject do
        perform_step(Metacrunch::UBPB::Transformations::MAB2SNR::Signature, read_mab_file(_filename)).target.values(field_name)
      end

      it { is_expected.to eq([_expected_value]) }
    end
  end
end
