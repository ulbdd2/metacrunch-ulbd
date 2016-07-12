require_relative "../helpers"

module Metacrunch::ULBD::Transformations::MabToVufind::Helpers::Merge
  def merge(value1, value2, options = {delimiter: ' ', wrap: nil})
    v1 = [value1].map(&:presence).compact.join(options[:delimiter])
    v2 = [value2].map(&:presence).compact.join(options[:delimiter])
    v2 = wrap(v2, options[:wrap]) if v2.present? and options[:wrap].present?
    [v1, v2].map(&:presence).compact.join(options[:delimiter])
  end

  def wrap(value, pattern)
    pattern.gsub("@", value)
  end
end
