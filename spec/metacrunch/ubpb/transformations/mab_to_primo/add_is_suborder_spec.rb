describe Metacrunch::UBPB::Transformations::MabToPrimo::AddIsSuborder do
  # check for superorders of secondary forms (mab 623 and 629)
  define_field_test '000806191', is_suborder: false
  define_field_test '000844686', is_suborder: false
  define_field_test '001452439', is_suborder: false
end
