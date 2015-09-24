describe Metacrunch::UBPB::Transformations::MabToPrimo::AddCorporateBodyCreatorDisplay do
  # egde case: only subfields g and h
  define_field_test '000017864', corporate_body_creator_display: [
    "Deutschland <Bundesrepublik>",
    "Deutschland <DDR>"
  ]

  # remove duplication of 200er fields (e.g. 200 and 204)
  define_field_test '000129575', corporate_body_creator_display: "Symposium on the Numerical Treatment of Ordinary Differential Equations, Integral and Integro-Differential Equations <1960, Rom>"

  define_field_test '000102057', corporate_body_creator_display: [
    "Projektträger DV im Bildungswesen",
    "Werkstattgespräch Analyse und Bewertung Wesentlicher Autoren- und Dialogsprachen für den Bereich des Bildungswesens <1973, Paderborn>"
  ]
  
  define_field_test '000143976', corporate_body_creator_display: [
    "Allgemeiner Kongress der Arbeiter- und Soldatenräte Deutschlands <1, 1918, Berlin>",
    "Deutschland <Deutsches Reich> / Zentralrat" # this differs from aleph, which only shows "Deutsches Reich, Zentralrat"
  ]
     
  define_field_test '000147985', corporate_body_creator_display: [
    "Seminar Abfallentsorgung durch Abfallverwertung <1979, Stuttgart>",
    "Forschungs- und Entwicklungsinstitut für Industrie- und Siedlungswasserwirtschaft sowie Abfallwirtschaft"
  ]

  # egde case: only subfields b, h and k (ind1: 'b')
  #define_field_test '000301195', corporate_body_creator_display: "Polska Akademia Nauk <Warschau> / Komitet Badań i Prognoz Polska 2000"
  #define_field_test '000335160', corporate_body_creator_display: "Deutschland <Bundesrepublik> / Bundestag"
end
