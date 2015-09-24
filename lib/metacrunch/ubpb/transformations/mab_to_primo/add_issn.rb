require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddIssn < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "issn", issn) : issn
  end

  private

  def issn
    issns = []

    source.datafields('542', ind2: '1').each do |_datafield|
      issns << _datafield.subfields('a').values if _datafield.ind1 != "z"
    end

    source.datafields('545', ind2: '1').each do |_datafield|
      issns << _datafield.subfields(['a','b','c','d']).values
    end

    source.datafields('635', ind2: '1').each do |_datafield|
      issns << _datafield.subfields('a').values if _datafield.ind1 != "z"
    end

    # RDA
    source.datafields('649', ind2: '1').each do |_datafield|
      issns << _datafield.subfields('x').values
    end

    issns.flatten.map{|v| v.gsub(/[^0-9\-x]/i, '').strip if v.present?}.map(&:presence).compact.uniq
  end
end
