require 'helper'

class LiveProject::ProjectTest < Test::Unit::TestCase

  context "Project" do

    setup do
      @project = TestHelper.project
    end

    context ".project" do

      should "populate project" do
        assert_not_nil @project.data
        assert_equal Hash, @project.data.class
      end

      should "populate tracks" do
        @project = TestHelper.project
        assert_not_nil @project.tracks
        assert_not_empty @project.tracks
        assert_not_nil @project.tracks[:midi]
        assert_not_empty @project.tracks[:midi]
        assert @project.tracks[:midi].first.kind_of?(LiveProject::Track::MIDI)
      end

      should "have working getters" do
        assert_equal @project.data["Ableton"]["Creator"], @project["Creator"]
      end

      should "have working setters" do
        @project["Creator"] = "blah"
        assert_equal "blah", @project["Creator"]
        assert_equal "blah", @project.data["Ableton"]["Creator"]
      end

      should "have working getter alias" do
        assert_equal @project.data["Ableton"]["Creator"], @project[:created_with_version]
      end

      should "have working setter alias" do
        @project[:created_with_version] = "blah!!"
        assert_equal "blah!!", @project[:created_with_version]
        assert_equal "blah!!", @project.data["Ableton"]["Creator"]
      end

    end

    context "#save" do

      should "save file" do
        original_file_size = File.size(@project.files.origin[:path])
        @project.save
        assert_not_equal original_file_size, File.size(@project.files.scratch[:path])
      end

    end

    context "#unzip" do

      should "unzip the raw project file" do
        FileUtils.rm(@project.files.xml[:path])
        @project.send(:unzip)
        assert File.exists?(@project.files.xml[:path])
        assert File.size(@project.files.xml[:path]) > 0
      end

    end

  end

end
