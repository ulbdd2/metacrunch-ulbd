describe (field_name = "display/title") do
  [
    ["PAD01.000057960.PRIMO.xml", "Sämtliche Werke : historisch-kritische Ausgabe"],
    ["PAD01.000058000.PRIMO.xml", "Tannhäuser"],
    ["PAD01.000215104.PRIMO.xml", "Hiersemanns bibliographische Handbücher"],
    ["PAD01.000310864.PRIMO.xml", "Paderborner Universitätsreden"],
    ["PAD01.000392641.PRIMO.xml", "Hegel-Jahrbuch"],
    ["PAD01.000392645.PRIMO.xml", "Hegel-Jahrbuch"],
    ["PAD01.000438377.PRIMO.xml", "Urkundenregesten zur Tätigkeit des deutschen Königs- und Hofgerichts bis 1451"],
    ["PAD01.000637121.PRIMO.xml", "Zeitschrift für Familienforschung : ZfF"],
    ["PAD01.000676616.PRIMO.xml", "Recht und Staat"],
    ["PAD01.000782994.PRIMO.xml", "Rot"],
    ["PAD01.001006945.PRIMO.xml", "Die Zeit Wenzels 1397 - 1400"],
    ["PAD01.001015067.PRIMO.xml", "Forum Geschichte kompakt"],
    ["PAD01.001015070.PRIMO.xml", "Vom Ende des Ersten Weltkriegs bis zur Gegenwart [Schülerbd.]"],
    ["PAD01.001108212.PRIMO.xml", "Johann Nestroy - Dokumente"],
    ["PAD01.001249043.PRIMO.xml", "Fractions, decimals, ratios, and percents"], # replace [Hauptbd.] with name of superorder
    ["PAD01.001499877.PRIMO.xml", "Fakten und Fiktionen : Werklexikon der deutschsprachigen Schlüsselliteratur ; 1900 - 2010"],
    ["PAD01.001499879.PRIMO.xml", "Andres bis Loest"],
    ["PAD01.001499880.PRIMO.xml", "Heinrich Mann bis Zwerenz"],
    ["PAD01.001510878.PRIMO.xml", "Tanzhaus"], # short title would be '[Buch]", so take the superorder title
    ["PAD01.001562173.PRIMO.xml", "Schwerpunktthema: Türkische Familien in Deutschland - Generationenbeziehungen und Generationenperspektiven"],
    ["PAD01.001568334.PRIMO.xml", "Software Engineering 2013"], # short title would be 'Buch", so take the superorder title
    ["PAD01.001572048.PRIMO.xml", "Paderborner Rathaus-Vorlesungen"],
    ["PAD01.001572049.PRIMO.xml", "Alte und Neue Welt : zur wechselvollen Geschichte transatlanitischer Kulturkontakte"],

    # use value in 310
    ["PAD01.000452919.PRIMO.xml", "Statistik des Auslandes / Länderbericht / Korea, Demokratische Volksrepublik"],
    ["PAD01.000695045.PRIMO.xml", "Zeitschrift für Urheber- und Medienrecht / Sonderheft"],
    ["PAD01.000479391.PRIMO.xml", "Quellen und Forschungen zur höchsten Gerichtsbarkeit im alten Reich / Sonderreihe"],

    # UV167
    ["PAD01.000605735.PRIMO.xml", "Zeitschrift für Urheber- und Medienrecht : ZUM"],
    ["PAD01.000695045.PRIMO.xml", "Zeitschrift für Urheber- und Medienrecht / Sonderheft"],
    ["PAD01.001209722.PRIMO.xml", "Zeitschrift für Urheber- und Medienrecht [Elektronische Ressource] : ZUM"],
    ["PAD01.001209723.PRIMO.xml", "Zeitschrift für Urheber- und Medienrecht / Rechtsprechungsdienst"],

    # UV183
    ["PAD01.000897969.PRIMO.xml", "Praxis Geschichte : Zeitschrift für den Geschichtsunterricht in der Sek I/II"],
    ["PAD01.000998195.PRIMO.xml", "Praxis Geschichte [Elektronische Ressource]"],
    ["PAD01.000558925.PRIMO.xml", "Der fremdsprachliche Unterricht / Englisch"]
  ]
  .each do |_filename, _expected_value|
    context "for #{_filename}" do
      subject do
        perform_step(Metacrunch::UBPB::Transformations::MAB2SNR::Title, read_mab_file(_filename)).target.values(field_name)
      end

      it { is_expected.to eq([_expected_value]) }
    end
  end
end
