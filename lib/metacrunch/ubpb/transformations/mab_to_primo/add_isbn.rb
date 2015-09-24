require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddIsbn < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "isbn", isbn) : isbn
  end

  private

  def isbn
    isbns = []

    source.datafields('086', ind2: '1').each do |_datafield|
      isbns << _datafield.subfields(['b','c','d']).values
    end

    source.datafields('540', ind2: '1').each do |_datafield|
      isbns << _datafield.subfields('a').values if _datafield.ind1 != "z"
    end

    source.datafields('634', ind2: '1').each do |_datafield|
      isbns << _datafield.subfields('a').values if _datafield.ind1 != "z"
    end

    # RDA
    source.datafields('649', ind2: '1').each do |_datafield|
      isbns << _datafield.subfields('z').values
    end

    isbns.flatten.map{|v| v.gsub(/[^0-9\-x]/i, '').strip if v.present?}.map(&:presence).compact.uniq
  end
end
