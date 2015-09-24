describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSignature do
  # Zeitschriftensignaturen
  define_field_test '000321365', signature: 'P10/34k12'
  define_field_test '000636652', signature: 'P10/34m3'
  define_field_test '000857994', signature: 'P10/34t26'

  define_field_test '000765779', signature: 'P10/34t24'
  define_field_test '000869906', signature: 'P10/34t24'
  define_field_test '001414237', signature: 'P10/34t24'

  # Signaturen
  define_field_test '000859176', signature: 'KDVD1105'
  define_field_test '000969442', signature: 'TWR12765'

  # Signatur mit anhängiger Bandzählung
  define_field_test '000161445', signature: 'KXW4113-80/81'
  define_field_test '001006945', signature: 'LKL2468-14'

  # UV183
  define_field_test '000318290', signature: 'P30/43g18' # Geographie heute
  define_field_test '000897969', signature: 'P30/40p8'  # Praxis Geschichte
  define_field_test '000998195', signature: 'P96/40p8'  # Praxis Geschichte [Elektronische Ressource]
  define_field_test '001518782', signature: 'P30/43g18' # Geographie heute

  # missing subfield 0
  define_field_test '000695094', signature: 'P30/49p30'
end
