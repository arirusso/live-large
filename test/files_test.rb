require 'helper'

class LiveProject::FilesTest < Test::Unit::TestCase

  context "Files" do

    context "#copy_to_workspace" do

      setup do
        @project_files = LiveProject::Files.new("test/assets/test Project/test.als", "test/scratch")
      end

      should "copy to workspace" do
        @project_files.send(:copy_to_workspace)
        assert File.exists?(@project_files.scratch[:path])
      end

    end
  end

end
