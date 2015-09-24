describe Metacrunch::UBPB::Transformations::MabToPrimo::AddNotationSort do
  define_field_test '000970649', notation_sort: 'LUHL' # multiple notations -> take the last one
  define_field_test '001006944', notation_sort: 'LKL'  # single notation
end
