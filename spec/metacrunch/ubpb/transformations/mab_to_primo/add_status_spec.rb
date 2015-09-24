describe Metacrunch::UBPB::Transformations::MabToPrimo::AddStatus do
  # gelöscht -> LDR Position 6 == 'd'
  define_field_test '000321365', status: 'D'

  # ausgesondert über Feld 078
  define_field_test '000392641', status: 'D'

  # Standort Detmold unterdrücken
  define_field_test 'detmold_1', status: 'D'
  define_field_test 'detmold_2', status: 'A'
  define_field_test 'detmold_3', status: 'A'

  # Interimsaufnahmen unterdrücken
  define_field_test '000898036', status: 'D'
end
