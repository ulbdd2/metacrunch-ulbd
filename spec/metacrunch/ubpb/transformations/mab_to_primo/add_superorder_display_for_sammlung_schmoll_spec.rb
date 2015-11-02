describe Metacrunch::UBPB::Transformations::MabToPrimo::AddSuperorderDisplayForSammlungSchmoll do
  # add "dummy superorder" "Sammlung J. A. Schmoll gen. Eisenwerth" for records with signature ZZVS1009
  define_field_test '000062467', superorder_display: "{\"ht_number\":null,\"label\":\"Sammlung J. A. Schmoll gen. Eisenwerth\",\"volume_count\":null,\"label_additions\":null}"
end
