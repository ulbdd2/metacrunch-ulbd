require "metacrunch/mab2"
require_relative "./ubpb/version"

module Metacrunch
  module ULBD
    require_relative "./transformator" # FIXME: Should be moved to the Metacrunch::UBPB namespace
    require_relative "./hash" # FIXME: Should be moved to the Metacrunch::UBPB namespace
    require_relative "./ulbd/transformations"
  end
end


