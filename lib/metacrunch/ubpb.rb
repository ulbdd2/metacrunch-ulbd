require "metacrunch"
require "metacrunch/mab2"
require "metacrunch/elasticsearch"
require_relative "./ubpb/version"

begin
  require "pry"
rescue LoadError ; end

module Metacrunch
  module UBPB
    require_relative "./ubpb/cli"
    require_relative "./ubpb/transformations"

    def self.root
      Gem::Specification.find_by_name("metacrunch-ubpb").gem_dir
    end
  end
end


