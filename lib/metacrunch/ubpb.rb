require "metacrunch"
require "metacrunch/mab2"
require "metacrunch/elasticsearch"

begin
  require "pry"
rescue LoadError ; end

module Metacrunch
  module UBPB
    require_relative "./ubpb/version"
    require_relative "./ubpb/cli"

    def self.root
      Gem::Specification.find_by_name("metacrunch-ubpb").gem_dir
    end
  end
end


