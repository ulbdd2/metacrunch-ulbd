describe Metacrunch::UBPB::Transformations::MabToPrimo::AddTitleSearch do
  define_field_test 'test_1', title_search: ['AAA', 'XXX', 'YYY']

  # If there are words with dashes inside, create a field with/and one without dash
  define_field_test '000253702', title_search: [
    "Ernährungs-Umschau : Forschung & Praxis ; Organ der Deutschen Gesellschaft für Ernährung e.V. (DGE), des Verbandes der Diätassistenten, Deutscher Bundesverband e.V. (VDD), der Gütegemeinschaft Diät und Vollkost e.V. (GDV), des Verbandes der Oecotrophologen e.V. (VDOE), des Bundesverbandes Deutscher Ernährungsmediziner e.V. (BDEM)",
    "Ernährungsumschau : Forschung & Praxis ; Organ Der Deutschen Gesellschaft Für Ernährung E.v. (dge), Des Verbandes Der Diätassistenten, Deutscher Bundesverband E.v. (vdd), Der Gütegemeinschaft Diät Und Vollkost E.v. (gdv), Des Verbandes Der Oecotrophologen E.v. (vdoe), Des Bundesverbandes Deutscher Ernährungsmediziner E.v. (bdem)",
    "Gemeinschafts-Verpflegung",
    "Gemeinschaftsverpflegung",
    "Zeitschrift über die Ernährung des Gesunden und Kranken",
    "Ernaehr.-Umsch.",
    "ERNAEHR UMSCH",
    "ERNAHR.-UMSCH.",
    "ERUMA",
    "Ernährungs-Umschau",
    "Ernährungsumschau",
    "Arbeitsgemeinschaft Ernährungsverhalten: Schriftenreihe der Arbeitsgemeinschaft Ernährungsverhalten",
    "<<Die>> Gesundheit",
    "Deutsche Gesellschaft für Ernährung: DGE-Info",
    "Cholesterin, die andere Meinung",
    "Ernährungslehre und -Praxis",
    "Aktuell",
    "Deutsche Gesellschaft für Ernährung: Kurzfassung der Vorträge",
    "Vereinigung Staatlich Anerkannter Diätassistentinnen und Ernährungsberaterinnen Deutschlands: Vorträge der Fortbildungstagung der Vereinigung Staatlich Anerkannter Diätassistentinnen und Ernährungsberaterinnen Deutschlands",
    "Verband Deutscher Diätassistenten: Vorträge der Fortbildungstagung des Verbandes Deutscher Diätassistenten e.V.",
    "Verband der Diätassistenten: Vorträge der Fortbildungstagung des Verbandes der Diätassistenten - Deutscher Bundesverband e.V."
  ]

  # ubpb/catalog#407
  define_field_test '001584494', title_search: [
    "Bericht der Bundesregierung über die Lage der Familien in der Bundesrepublik Deutschland",
    "Verhandlungen des Deutschen Bundestages / Anlagen zu den stenographischen Berichten / Bericht der Bundesregierung über die Lage der Familien in der Bundesrepublik Deutschland",
    "Bericht über die Lage der Familien in der Bundesrepublik Deutschland",
    "Familienbericht",
    "Bericht über die Lage der Familien in der Bundesrepublik Deutschland. - Familienbericht", "Familienberichte der Bundesregierung",
    "Deutschland <Bundesrepublik> / Bundestag: Verhandlungen des Deutschen Bundestages / Anlagen zu den stenographischen Berichten"
  ]

  # RDA - frühere Titel
  define_field_test 'HBZ07.090397503', title_search: ["KHS competence", "KHS competence in solutions"]
end
