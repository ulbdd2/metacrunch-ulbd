require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_superorder_display"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSuperorder < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "superorder", superorder) : superorder
  end

  private

  def superorder
    superorders = []

    f623 = source.datafields('623').value # Identifikationsnummer des 1. GT der Sekundärform
    f629 = source.datafields('629').value # Identifikationsnummer des 2. GT der Sekundärform

    superorders << if (json_encoded_superorders_display = superorder_display).present?
      superorders_display = [json_encoded_superorders_display].flatten(1).compact.map { |json_encoded_superorder_display| JSON.parse(json_encoded_superorder_display) }
      superorders_display.map { |superorder_display| superorder_display['ht_number'] }
    end

    superorders << f623 if f623.present?
    superorders << f629 if f629.present?

    # RDA
    source.datafields("649", ind2: "1").each do |_datafield|
      if identifikationsnummer = _datafield.subfields("9").value
        superorders << identifikationsnummer
      end
    end

    superorders.flatten.map(&:presence).compact
  end

  private

  def superorder_display
    target.try(:[], "superorder_display") || self.class.parent::AddSuperorderDisplay.new(source: source).call
  end
end
