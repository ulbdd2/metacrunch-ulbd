describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSecondaryFormIsbn do
  define_field_test '000806191', secondary_form_isbn: '3-8288-0675-9'
  define_field_test '000844686', secondary_form_isbn: '3-8288-1141-8'
  define_field_test '001452439', secondary_form_isbn: nil
end
