module LiveProject

  class Files

    attr_reader :origin, 
                :scratch, 
                :xml

    def initialize(path, scratch_directory)
      initialize_paths(path, scratch_directory)
      ensure_scratch_directory(scratch_directory)
      copy_to_workspace
    end

    private

    def ensure_scratch_directory(scratch_directory)
      Dir.mkdir(scratch_directory) unless Dir.exists?(scratch_directory)
    end

    def initialize_paths(path, scratch_directory)
      filename = path.include?("/") ? path.split(/^(.+)\/([^\/]+)$/).last : path
      xml_filename = filename.gsub(/\.als/, ".xml")
      @origin = {
        :path => path,
        :filename => filename
      }
      @scratch = {
        :path => "#{scratch_directory}/#{filename}",
        :filename => filename
      }
      @xml = {
        :path => "#{scratch_directory}/#{xml_filename}",
        :filename => xml_filename
      }
    end

    def copy_to_workspace
      FileUtils.cp(@origin[:path], @scratch[:path])
    end

  end

end

