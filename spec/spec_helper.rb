require "metacrunch/ubpb"
Dir.glob(File.join(__dir__, "helpers", "**", "*.rb"), &method(:require))


RSpec.configure do |config|
  config.include TransformationHelper
end

# Helper to provide RSpec.root
module ::RSpec
  module_function
  def root
    @spec_root ||= Pathname.new(__dir__)
  end
end
