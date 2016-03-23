describe Metacrunch::UBPB::Transformations::MabToPrimo::AddRelation do
  # no relation
  define_field_test '000438377', relation: nil

  # multiple relations
  define_field_test '000637121', relation: [
    "{\"ht_number\":\"HT015774588\",\"label\":\"Online-Ausg.: Zeitschrift für Familienforschung\"}",
    "{\"ht_number\":\"HT015774666\",\"label\":\"Stein-Ausg.: Zeitschrift für Familienforschung\"}",
    "{\"ht_number\":\"HT013503432\",\"label\":\"Ab 1994 Sonderh.: Zeitschrift für Familienforschung / Sonderheft\"}"
  ]
    
  # primary form relation
  define_field_test '000806191', relation: "{\"ht_number\":\"HT010843875\",\"label\":\"Primärform\"}"
  define_field_test '001452439', relation: "{\"ht_number\":\"HT016964750\",\"label\":\"Primärform\"}"

  # secondary form relation (ubpb/catalog#403)
  define_field_test '000968502', relation: "{\"ht_number\":\"HT016666600\",\"label\":\"Sekundärform\"}"

  define_field_test '001840251', relation: [
    "{\"ht_number\":\"HT018830722\",\"label\":\"Parallele Sprachausgabe französisch: Filati special\"}",
    "{\"ht_number\":\"HT018830720\",\"label\":\"Parallele Sprachausgabe niederländisch: Filati special\"}"
  ]

  # belongs to example above
  define_field_test '001840250', relation: [
    "{\"ht_number\":\"HT018830723\",\"label\":\"Parallele Sprachausgabe deutsch: Filati special\"}",
    "{\"ht_number\":\"HT018830722\",\"label\":\"Parallele Sprachausgabe französisch: Filati special\"}"
  ]
end
