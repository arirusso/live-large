#!/usr/bin/env ruby

require 'helper'

class LiveProject::ProjectTest < Test::Unit::TestCase

  def test_populate_data
    @project = TestHelper.project
    assert_not_nil @project.data
    assert_equal Hash, @project.data.class
  end

  def test_populate_tracks
    @project = TestHelper.project
    assert_not_nil @project.tracks
    assert_not_empty @project.tracks
    assert_not_nil @project.tracks[:midi]
    assert_not_empty @project.tracks[:midi]
    assert @project.tracks[:midi].first.kind_of?(LiveProject::Track::MIDI)
  end

  def test_getter
    @project = TestHelper.project
    assert_equal @project.data["Ableton"]["Creator"], @project["Creator"]
  end

  def test_setter
    @project = TestHelper.project
    @project["Creator"] = "blah"
    assert_equal "blah", @project["Creator"]
    assert_equal "blah", @project.data["Ableton"]["Creator"]
  end

  def test_getter_alias
    @project = TestHelper.project
    assert_equal @project.data["Ableton"]["Creator"], @project[:created_with_version]
  end

  def test_setter_alias
    @project = TestHelper.project
    @project[:created_with_version] = "blah!!"
    assert_equal "blah!!", @project[:created_with_version]
    assert_equal "blah!!", @project.data["Ableton"]["Creator"]
  end

  def test_save
    @project = TestHelper.project
    original_file_size = File.size(@project.files.origin[:path])
    @project.save
    assert_not_equal original_file_size, File.size(@project.files.scratch[:path])
  end

  def test_unzip
    @project = TestHelper.project
    FileUtils.rm(@project.files.xml[:path])
    @project.send(:unzip)
    assert File.exists?(@project.files.xml[:path])
    assert File.size(@project.files.xml[:path]) > 0
  end

end
