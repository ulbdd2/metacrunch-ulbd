describe Metacrunch::UBPB::Transformations::MabToPrimo::AddCreationdate do
  # Erscheinungsjahr der Quelle in 595 hat Vorrang vor 425
  define_field_test '595_1', creationdate: '1994'

  # Test 425 Unterfalder b und c (offene/geschlossene Verläufe)
  define_field_test '425_bc_1', creationdate: '2005 -'
  define_field_test '425_bc_2', creationdate: '2005 - 2010'
  define_field_test '425_bc_3', creationdate: '2005'
  define_field_test '425_bc_4', creationdate: '- 2005'

  # Erscheinungsjahr aus 425a
  define_field_test '425_a_1', creationdate: '2005'
  # Erscheinungsjahr aus 425 a (Mehrbändig)
  define_field_test '425_a_2', creationdate: '2005'

  # Erscheinungsjahr aus 425p
  define_field_test '425_p_1', creationdate: '2010'
  # Erscheinungsjahr aus 425 a (Mehrbändig)
  define_field_test '425_p_2', creationdate: '2010'
end
