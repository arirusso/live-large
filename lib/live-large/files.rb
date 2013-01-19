#!/usr/bin/env ruby

module LiveLarge

  class Files

    attr_reader :origin, 
                :scratch, 
                :xml

    def initialize(path)
      initialize_paths(path)
      copy_to_workspace
    end

    private

    def initialize_paths(path)
      filename = path.include?("/") ? path.split(/^(.+)\/([^\/]+)$/).last : path
      xml_filename = filename.gsub(/\.als/, ".xml")
      @origin = {
        :path => path,
        :filename => filename
      }
      @scratch = {
        :path => "workspace/#{filename}",
        :filename => filename
      }
      @xml = {
        :path => "workspace/#{xml_filename}",
        :filename => xml_filename
      }
    end

    def copy_to_workspace
      FileUtils.cp(@origin[:path], @scratch[:path])
    end

  end

end

