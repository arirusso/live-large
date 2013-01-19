#!/usr/bin/env ruby

require 'helper'

class ProjectTest < Test::Unit::TestCase

  def project
    LiveLarge::Project.new("/Users/russo/Documents/ableton/10.2 Project/10.2.als")
  end

  def test_populate_data
    @project = project
    assert_not_nil @project.data
    assert_equal Hash, @project.data.class
  end

end
