require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_erscheinungsform"

class Metacrunch::ULBD::Transformations::MabToVufind::AddDescription < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "description", description) : description
  end

  private

  def description
    descriptions = []

    # 405 - Erscheinungsverlauf von Zeitschriften
    descriptions << source.datafields('405', ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }

    # 522 - Teilungsvermerk bei fortlaufenden Sammelwerken
    descriptions << source.datafields('522', ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }

    # 523 - Erscheinungsverlauf von Monos
    descriptions << source.datafields('523', ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }

    # 064 - Art des Inhalts, Erweiterte Datenträgertypen
    descriptions << source.datafields('064', ind2: '1').map { |_field| _field.subfields(['a', 'x', 'z', 'y']).values.join(', ') }
        
    # 501
    descriptions.concat(source.datafields('501', ind2: '1').subfields('a').values)
   
  
    (502..519).each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end

    # RDA
    source.datafields('520').each do |_field| # Hochschulschriftenvermerk
      charakter_der_hochschulschrift       = _field.subfields('b').value
      name_der_institution_oder_fakultät   = _field.subfields('c').value
      jahr_in_dem_der_grad_verliehen_wurde = _field.subfields('d').value
      zusätzliche_angaben                  = _field.subfields('g').values.presence
      hochschulschriften_identifier        = _field.subfields('o').value

      _description = []
      _description << "#{charakter_der_hochschulschrift}:" if charakter_der_hochschulschrift
      _description << name_der_institution_oder_fakultät if name_der_institution_oder_fakultät
      _description << "(#{jahr_in_dem_der_grad_verliehen_wurde})" if jahr_in_dem_der_grad_verliehen_wurde
      _description << "[#{zusätzliche_angaben.join(", ")}]" if zusätzliche_angaben
      _description << "#{hochschulschriften_identifier}" if hochschulschriften_identifier

      descriptions << _description.join(" ")
    end

    (536..536).each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') } unless f == 537 && erscheinungsform == "journal"
    end

    # 655 - Zusatzinfo eletr. Ress.
    descriptions << source.datafields('655', ind2: ['1', '9']).map { |_field| _field.subfields('z').values }
    
    # 125 - Bemerkungen aus Lokalsatz
    #descriptions << source.datafields('125', ind1: 'a', ind2: '9').map { |_field| _field.subfields('a').values }
    
    # 200 - Kommentar aus Zeitschriftensignatur
    #descriptions << source.datafields('200', ind2: '9').map { |_field| _field.subfields('e').values }
     
    # 132 - Provenienz -> eigenes Feld
    #descriptions << source.datafields('132', ind1: 'p', ind2: '9').map { |_field| _field.subfields('a').values }

    #578 - Fingerprint -> eigenes Feld
    #descriptions << source.datafields('578', ind2: '1').map { |_field| _field.subfields('a').values }
    
    #580 - Sonstige Standardnummer
    #descriptions << source.datafields('580', ind2: '1').map { |_field| _field.subfields('a').values }
      
    unless kind_of?("Zeitschrift")
      descriptions << source.get("redaktionelle Bemerkungen").map(&:get)
    end

    descriptions <<
    [
      [
        source.get("Haupttitel der Quelle").first.try(:get),
        source.get("Verantwortlichkeitsangabe der Quelle").first.try(:get)
      ]
      .compact.join(" / ").presence,
      [
        source.get("Unterreihe der Quelle").first.try(:get),
        source.get("Ausgabebezeichnung der Quelle in Vorlageform").first.try(:get),
        [
          [
            "Verlagsorte der Quelle",
            "Druckorte der Quelle",
            "Vetriebsorte der Quelle",
            "Auslieferungsorte der Quelle"
          ]
          .map do |property|
            source.get(property).map(&:get)
          end
          .flatten.compact.join(", ").presence,
          source.get("Erscheinungsjahr der Quelle").first.try(:get)
        ]
        .compact.join(", ").presence,
        source.get("Reihe der Quelle").first.try(:get).try { |value| "(#{value})" },
        source.get("Zählungen der Quellen").map(&:get).join(", ")
      ]
      .compact.join(". - ").presence
    ]
    .compact.join(". ").presence

    # Finally...
    descriptions.flatten.map(&:presence).compact.uniq.join(". - ")
  end

  private

  def kind_of?(type)
    if type == "Zeitschrift"
      source
      .get("veröffentlichungsspezifische Angaben zu fortlaufenden Sammelwerken")
      .get("Erscheinungsform")
      .try do |value|
        [
          "continuing integrating resource",
          "zeitschriftenartige Reihe",
          "Zeitschrift",
          "Zeitung"
        ]
        .include?(value)
      end
      .try do |result|
        !!result
      end
    else
      false
    end
  end

  def erscheinungsform
    target.try(:[], "erscheinungsform") || self.class.parent::AddErscheinungsform.new(source: source).call
  end
end
