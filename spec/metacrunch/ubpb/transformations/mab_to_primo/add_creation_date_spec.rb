describe Metacrunch::UBPB::Transformations::MabToPrimo::AddCreationDate do
  define_field_test 'test1', creation_date: ['19780707', '19780708']
  define_field_test 'test2', creation_date: '19780707' # Unique dates will become one
end
