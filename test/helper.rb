#!/usr/bin/env ruby

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + "/../lib"

require "test/unit"
require "live-large"

class TestHelper

  class << self
    attr_reader :project
  end

  def self.project
    @project ||= LiveLarge::Project.new("/Users/russo/Documents/ableton/10.2 Project/10.2.als")
  end

end
