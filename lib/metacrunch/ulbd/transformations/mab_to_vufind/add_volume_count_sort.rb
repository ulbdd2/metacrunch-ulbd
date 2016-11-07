require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddVolumeCountSort < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "volume_count_sort_str", volume_count_sort) : volume_count_sort
  end

  private

  def volume_count_sort
    possible_values = []
    possible_values << source.datafields('090', ind2: '1').subfields('a').value
    (451..491).step(10) { |f| possible_values << source.datafields("#{f+5}", ind2: '1').subfields('a').value }
    count = possible_values.map(&:presence).compact.uniq.first

    if count.present?
      # extract the count groups
      count_groups = count.split(',')
      # make sure we have always 4 groups
      count_groups = Array.new(4) { |i| count_groups[i] }
      # make sure every group is a string
      count_groups.map!{ |g| g.to_s }
      # clean things up a bit
      count_groups.map!{ |g| g.gsub(/\[|\]/, '').strip }
      # fill up each group to 6 characters
      count_groups.map!{ |g| g.rjust(6, '0') }
      # make sure each group is really 6 characters.
      count_groups.map!{ |g| g[0..5] }
      # finally join
      count_groups.join
    else
      nil
    end
  end
end
