require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_erscheinungsform"

class Metacrunch::ULBD::Transformations::MabToVufind::AddDescriptionOs < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "description_os", description_os) : description_os
  end

  private

  def description_os
    descriptions = []
       
    # 501
    descriptions.concat(source.datafields('E01', ind2: '1').subfields('a').values)
   
  
    source.datafields('E02').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E04').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E05').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E06').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E07').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E08').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E09').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E10').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E11').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E12').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E17').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
    source.datafields('E19').each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end
    
       # RDA
    source.datafields('E20').each do |_field| # Hochschulschriftenvermerk
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

=begin    
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
=end
    # Finally...
    descriptions.flatten.map(&:presence).compact.uniq.join(". - ")
  end
=begin
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
=end  
end
