describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSignatureSearch do
  # Zeitschriftensignaturen
  define_field_test '000321365', signature_search: ["34K12", "34 K 12", "P10/34K12", "P 10/34 K 12"]
  define_field_test '000636652', signature_search: ["P10/34M3", "P 10/34 M 3", "34M3", "34 M 3"]
  define_field_test '000857994', signature_search: ["34T26", "34 T 26", "P10/34T26", "P 10/34 T 26"]
  define_field_test '000452919', signature_search: ["P02/49S105", "P 02/49 S 105", "49S105", "49 S 105"]

  define_field_test '000859176', signature_search: "KDVD1105"
  define_field_test '000969442', signature_search: ["TWR12765+4", "TWR12765", "TWR12765+1", "TWR12765+2", "TWR12765+3"]

  define_field_test '000765779', signature_search: ["34T24", "34 T 24", "P10/34T24", "P 10/34 T 24"]
  define_field_test '000869906', signature_search: ["34T24", "34 T 24", "P10/34T24", "P 10/34 T 24"]
  define_field_test '001414237', signature_search: ["34T24", "34 T 24", "P10/34T24", "P 10/34 T 24"]

  # Signatur mit anhängiger Bandzählung
  define_field_test '000161445', signature_search: ["KXW4113-80/81", "KXW4113-80", "KXW4113"]
  define_field_test '001006945', signature_search: ["LKL2468-14", "LKL2468"]

  # UV183
  define_field_test '000318290', signature_search: ["43G18", "43 G 18", "P96/43G18", "P 96/43 G 18", "P02/43G18", "P 02/43 G 18", "P30/43G18", "P 30/43 G 18"] # Geographie heute
  define_field_test '000897969', signature_search: ["40P8", "40 P 8", "P30/40P8", "P 30/40 P 8", "P96/40P8", "P 96/40 P 8"]                                    # Praxis Geschichte
  define_field_test '000998195', signature_search: ["40P8", "40 P 8", "P96/40P8", "P 96/40 P 8"]                                                               # Praxis Geschichte [Elektronische Ressource]
  define_field_test '001518782', signature_search: ["43G18", "43 G 18", "P30/43G18", "P 30/43 G 18"]                                                           # Geographie heute

  # missing subfield 0
  define_field_test '000695094', signature_search: ["P30/49P30", "P 30/49 P 30", "49P30", "49 P 30"]

  # add signature from LOC subfield f
  define_field_test '000062467', signature_search: ["M41972", "BPOF1032", "BPOF1032+1", "ZZVS1009"]

  # https://github.com/ubpb/issues/issues/54
  define_field_test '000517673', signature_search: ["CSCB6417+1", "CSCB6417"]
end
