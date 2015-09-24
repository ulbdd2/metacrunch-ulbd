describe Metacrunch::UBPB::Transformations::MabToPrimo::AddAuthorStatement do
  # only 359_1 is present
  define_field_test '000323362', author_statement: "Komm. d. Europ. Gemeinschaften, Generaldir. Beschäftigung, Soziale Angelegenheiten u. Bildung"

  # only 359_2 is present
  define_field_test '000307083', author_statement: "hrsg. von der Bundesanstalt für Arbeitsschutz, Dortmund. Erich Ott ... (Projektleitung)"

  # 359_1 and 359_2 are both present, so take 359_1
  define_field_test '000317603', author_statement: "Autoren: Günter L. Huber ..."

  # multiple 359er fields with same indicator
  define_field_test '001100110', author_statement: ["par M. De la Tour, premier président du Parlement de Provence. Lettre écrite à M. le controleur-général, le 13 juin 1768", "par M. de Bérulle, premier président du Parlement de Grenoble"]
end
