describe Metacrunch::UBPB::Transformations::MabToPrimo::AddShortTitleDisplay do
  define_field_test '000057960', short_title_display: 'Sämtliche Werke : historisch-kritische Ausgabe'
  define_field_test '000058000', short_title_display: 'Tannhäuser'
  define_field_test '000215104', short_title_display: 'Hiersemanns bibliographische Handbücher'
  define_field_test '000310864', short_title_display: 'Paderborner Universitätsreden'
  define_field_test '000392641', short_title_display: 'Hegel-Jahrbuch'
  define_field_test '000392645', short_title_display: 'Hegel-Jahrbuch'
  define_field_test '000438377', short_title_display: 'Urkundenregesten zur Tätigkeit des deutschen Königs- und Hofgerichts bis 1451'
  define_field_test '000637121', short_title_display: 'Zeitschrift für Familienforschung : ZfF'
  define_field_test '000676616', short_title_display: 'Recht und Staat'
  define_field_test '000782994', short_title_display: 'Rot'
  define_field_test '001006945', short_title_display: 'Die Zeit Wenzels 1397 - 1400'
  define_field_test '001015067', short_title_display: 'Forum Geschichte kompakt'
  define_field_test '001015070', short_title_display: 'Vom Ende des Ersten Weltkriegs bis zur Gegenwart [Schülerbd.]'
  define_field_test '001108212', short_title_display: 'Johann Nestroy - Dokumente'
  define_field_test '001249043', short_title_display: 'Fractions, decimals, ratios, and percents' # replace [Hauptbd.] with name of superorder
  define_field_test '001499877', short_title_display: 'Fakten und Fiktionen : Werklexikon der deutschsprachigen Schlüsselliteratur ; 1900 - 2010'
  define_field_test '001499879', short_title_display: 'Andres bis Loest'
  define_field_test '001499880', short_title_display: 'Heinrich Mann bis Zwerenz'
  define_field_test '001510878', short_title_display: 'Tanzhaus' # short title would be '[Buch]', so take the superorder title
  define_field_test '001562173', short_title_display: 'Schwerpunktthema: Türkische Familien in Deutschland - Generationenbeziehungen und Generationenperspektiven'
  define_field_test '001568334', short_title_display: 'Software Engineering 2013' # short title would be 'Buch', so take the superorder title
  define_field_test '001572048', short_title_display: 'Paderborner Rathaus-Vorlesungen'
  define_field_test '001572049', short_title_display: 'Alte und Neue Welt : zur wechselvollen Geschichte transatlanitischer Kulturkontakte'

  # use value in 310
  define_field_test '000452919', short_title_display: 'Statistik des Auslandes / Länderbericht / Korea, Demokratische Volksrepublik'
  define_field_test '000695045', short_title_display: 'Zeitschrift für Urheber- und Medienrecht / Sonderheft'
  define_field_test '000479391', short_title_display: 'Quellen und Forschungen zur höchsten Gerichtsbarkeit im alten Reich / Sonderreihe'

  # UV167
  define_field_test '000605735', short_title_display: 'Zeitschrift für Urheber- und Medienrecht : ZUM'
  define_field_test '000695045', short_title_display: 'Zeitschrift für Urheber- und Medienrecht / Sonderheft'
  define_field_test '001209722', short_title_display: 'Zeitschrift für Urheber- und Medienrecht [Elektronische Ressource] : ZUM'
  define_field_test '001209723', short_title_display: 'Zeitschrift für Urheber- und Medienrecht / Rechtsprechungsdienst'

  # UV183
  define_field_test '000897969', short_title_display: 'Praxis Geschichte : Zeitschrift für den Geschichtsunterricht in der Sek I/II'
  define_field_test '000998195', short_title_display: 'Praxis Geschichte [Elektronische Ressource]'

  #
  define_field_test '000558925', short_title_display: 'Der fremdsprachliche Unterricht / Englisch'
end
