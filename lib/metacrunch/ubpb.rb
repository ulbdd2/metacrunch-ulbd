require "metacrunch"
require "metacrunch/mab2"

begin
  require "pry"
rescue LoadError ; end

module Metacrunch
  module UBPB
    require_relative "./ubpb/version"
    require_relative "./ubpb/cli"
  end
end


