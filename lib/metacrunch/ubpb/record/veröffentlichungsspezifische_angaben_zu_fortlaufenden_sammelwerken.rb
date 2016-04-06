require_relative "./generic_controlfield"

class Metacrunch::UBPB::Record::VeröffentlichungsspezifischeAngabenZuFortlaufendenSammelwerken < Metacrunch::UBPB::Record::GenericControlfield
  POSITIONS = {
    0 => {
      Erscheinungsform:  {
        a: "unselbständig erschienenes Werk",
        f: "Fortsetzung",
        i: "continuing integrating resource",
        j: "zeitschriftenartige Reihe",
        p: "Zeitschrift",
        r: "Schriftenreihe (Serie)",
        z: "Zeitung"
      }
    },
    1..6 => {
      Veröffentlichungsart: {
        aa: "Amtsblatt",
        am: "Amts- und Gesetzblatt",
        az: "Anzeigenblatt",
        au: "Aufsatz",
        bi: "Bibliographie",
        kt: "Bibliothekskatalog",
        da: "Datenbank",
        di: "Directory",
        ww: "Dissertation",
        es: "Entscheidungssammlung",
        ft: "Fachzeitung",
        fs: "Festschrift",
        fz: "Firmenzeitschrift/-zeitung",
        fb: "Fortschrittsbericht",
        ag: "Gesetz(und Verdordnungs-)blatt",
        ha: "Haushaltsplan",
        il: "Illustrierte",
        in: "Index",
        ko: "Konferenzschrift / Kongressbericht",
        mg: "Magazin",
        me: "Messeblatt",
        pa: "Parlamentaria",
        rf: "Referateorgan",
        re: "Report-Serie",
        sc: "Schul- / Universitätsschrift",
        se: "Serie",
        so: "Sonderdruck",
        xj: "Sonstige Periodika, juristische",
        st: "Statistik",
        ub: "Übersetzungszeitschrift",
        wb: "Wörterbuch",
        bg: "Biographie",
        ez: "Enzyklopädie",
        li: "Lieferungswerk",
        lo: "Loseblattausgabe",
        mu: "Musikalia",
        no: "Normschrift",
        pt: "Patentdokument",
        rg: "Registerwerk",
        ws: "Website",
        uu: "sonstige Veröffentlichungsart/-inhalt",
        ao: "Zeitung für die allgemeine Öffentlichkeit",
        eo: "Zeitung für eine eingeschränkte Öffentlichkeit",
        up: "Überregionale Zeitung",
        rp: "Regionale Zeitung",
        lp: "Lokale Zeitung"
      }
    }
  }
end
