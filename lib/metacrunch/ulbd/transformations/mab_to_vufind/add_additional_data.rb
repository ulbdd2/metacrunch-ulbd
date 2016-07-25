require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddAdditionalData < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "additional_data_str_mv", additional_data) : additional_data
  end

  private

  def additional_data
    additional_data = {
      local_comment:                      [local_comment].flatten(1).compact.presence
    }
    .inject({}) { |hash, (key, value)| hash[key] = value if value.present?; hash }

    additional_data.to_json if additional_data.present?
  end

  private

  def local_comment
    target.try(:[], "local_comment") || self.class.parent::AddLocalComment.new(source: source).call
  end
end
