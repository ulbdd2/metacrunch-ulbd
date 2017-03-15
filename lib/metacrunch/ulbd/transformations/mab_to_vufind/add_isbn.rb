require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddIsbn < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "isbn", isbn) : isbn
  end

  private

  def isbn
    isbns = []

    source.datafields('086', ind2: '1').each do |_datafield|
      isbns << _datafield.subfields(['b','c','d']).values
    end
    
    source.datafields('776', ind2: '1').each do |_datafield|
      isbns << _datafield.subfields('z').values
    end

    source.get("ISBNs", include: ["formal falsch", "formal ungeprüft"]).each do |isbn|
      isbns << isbn.get
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
