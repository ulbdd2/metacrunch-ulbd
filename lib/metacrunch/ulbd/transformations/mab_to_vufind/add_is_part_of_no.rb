require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_superorder_display"

class Metacrunch::ULBD::Transformations::MabToVufind::AddIsPartOfNo < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "is_part_of_no_txt_mv", ipono) : ipono
  end

  private

  def ipono
    iponumber = []

    iponumber << if (json_encoded_is_part_of = is_part_of).present?
      is_part_of = [json_encoded_is_part_of].flatten(1).compact.map { |json_encoded_superorder_display| JSON.parse(json_encoded_superorder_display) }
      is_part_of.map { |is_part_of| is_part_of['ht_number'] }
    end


    iponumber.flatten.map(&:presence).compact
  end

  private

  def is_part_of
    target.try(:[], "is_part_of") || self.class.parent::AddIsPartOf.new(source: source).call
  end
end
