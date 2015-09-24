describe Metacrunch::UBPB::Transformations::MabToPrimo::AddIsSecondaryForm do
  define_field_test '000806191', is_secondary_form: true
  define_field_test '000844686', is_secondary_form: true
  define_field_test '001015067', is_secondary_form: false
  define_field_test '001452439', is_secondary_form: true
end
