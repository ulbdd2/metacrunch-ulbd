require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./add_erscheinungsform"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddDescription < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "description", description) : description
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

    # 501
    descriptions.concat(source.datafields('501', ind2: '1').subfields('a').values)

    (502..519).each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') }
    end

    # RDA
    source.datafields('520').each do |_field| # Hochschulschriftenvermerk
      charakter_der_hochschulschrift       = _field.subfield('b').value
      name_der_institution_oder_fakultät   = _field.subfield('b').value
      jahr_in_dem_der_grad_verliehen_wurde = _field.subfield('d').value
      zusätzliche_angaben                  = _field.subfield('g').values.presence
      hochschulschriften_identifier        = _field.subfield('o').value

      _description = []
      _description << "#{charakter_der_hochschulschrift}:" if charakter_der_hochschulschrift
      _description << name_der_institution_oder_fakultät if name_der_institution_oder_fakultät
      _description << "(#{jahr_in_dem_der_grad_verliehen_wurde})" if jahr_in_dem_der_grad_verliehen_wurde
      _description << "[#{zusätzliche_angaben.join(", ")}]" if zusätzliche_angaben
      _description << "#{hochschulschriften_identifier}" if hochschulschriften_identifier

      descriptions << _description.join(" ")
    end

    (536..537).each do |f|
      descriptions << source.datafields("#{f}", ind2: '1').map { |_field| _field.subfields(['p', 'a']).values.join(': ') } unless f == 537 && erscheinungsform == "journal"
    end

    # Finally...
    descriptions.flatten.map(&:presence).compact.uniq
  end

  private

  def erscheinungsform
    target.try(:[], "erscheinungsform") || self.class.parent::AddErscheinungsform.new(source: source).call
  end
end