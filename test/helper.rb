dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require "test/unit"
require "mocha/test_unit"
require "shoulda-context"

require "live-project"

class TestHelper

  class << self
    attr_reader :project
  end

  def self.project
    @project ||= LiveProject::Project.new("test/assets/test Project/test.als", :scratch_directory => "test/scratch")
  end

end
