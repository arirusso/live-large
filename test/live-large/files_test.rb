#!/usr/bin/env ruby

require 'helper'

class ProjectTest < Test::Unit::TestCase

  def project_files
    LiveLarge::Files.new("/Users/russo/Documents/ableton/10.2 Project/10.2.als")
  end

  def test_copy_to_workspace
    @project_files = project_files
    @project_files.send(:copy_to_workspace)
    assert File.exists?(project_files.scratch[:path])
  end

end

