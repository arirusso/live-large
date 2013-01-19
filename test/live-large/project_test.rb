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

  def test_save
    @project = project
    original_file_size = File.size(@project.files.origin[:path])
    @project.save
    assert_not_equal original_file_size, File.size(@project.files.scratch[:path])
  end

  def test_unzip
    @project = project
    FileUtils.rm(@project.files.xml[:path])
    @project.send(:unzip)
    assert File.exists?(@project.files.xml[:path])
    assert File.size(@project.files.xml[:path]) > 0
  end

end
