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

  define_field_test '001700103', relation: [
    "{\"ht_number\":\"HT012566869\",\"label\":\"Druckausg.: Unsere Zeit in Bild und Wort\"}",
    "{\"ht_number\":\"HT012566844\",\"label\":\"Beil. zu: Aidenbacher Anzeiger\"}",
    "{\"ht_number\":\"HT007017773\",\"label\":\"Beil. zu: Bamberger Volksblatt\"}",
    "{\"ht_number\":\"HT018185202\",\"label\":\"Beil. zu: Zwischen Maas und Mosel\"}",
    "{\"ht_number\":\"HT018198338\",\"label\":\"Beil. zu: Nowogrodeker Kriegszeitung\"}",
    "{\"label\":\"Beil. zu: Haarbacher Wochenblatt\"}",
    "{\"label\":\"Beil. zu: Neuer Vilstaler Bote\"}",
    "{\"ht_number\":\"HT014172573\",\"label\":\"Beil. zu: Scheinfelder Kurier\"}"
  ]

  define_field_test '001700493', relation: "{\"ht_number\":\"HT006911370\",\"label\":\"Druckausg. u. Vorg.: Folia orientalia\"}"

  define_field_test '001700512', relation: [
    "{\"ht_number\":\"HT012511635\",\"label\":\"Druckausg.: Vollberechtigtes Progymnasium \\u003cPreußisch Friedland\\u003e: Programm des Vollberechtigten Progymnasiums zu Pr. Friedland\"}",
    "{\"label\":\"Vorg.: Progymnasium\"}",
    "{\"ht_number\":\"HT018191816\",\"label\":\"Forts.: Vollberechtigtes Königliches Progymnasium \\u003cPreußisch Friedland\\u003e: Programm des Vollberechtigten Königlichen Progymnasiums zu Pr. Friedland\"}"
  ]

  define_field_test '001704475', relation: [
    "{\"ht_number\":\"HT018216703\",\"label\":\"Daraus hervorgeg.: Fachbrief Englisch Grundschule\"}",
    "{\"ht_number\":\"HT018216702\",\"label\":\"12=1; 28=2 von: Fachbrief Moderne Fremdsprachen\"}",
    "{\"ht_number\":\"HT018216625\",\"label\":\"5=4; 12=7; 28=13 von: Fachbrief Französisch\"}",
    "{\"ht_number\":\"HT018216624\",\"label\":\"12=5; 28=10 von: Fachbrief Italienisch\"}",
    "{\"ht_number\":\"HT018216626\",\"label\":\"12=5; 28=12 von: Fachbrief Russisch\"}",
    "{\"ht_number\":\"HT018216627\",\"label\":\"12=6; 28=11 von: Fachbrief Spanisch\"}",
    "{\"ht_number\":\"HT018216701\",\"label\":\"12=5; 28=6 von: Fachbrief Türkisch\"}"
  ]
end
