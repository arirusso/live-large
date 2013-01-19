#!/usr/bin/env ruby

module LiveLarge

  class Project

    attr_reader :data, :files

    def initialize(path, &block)
      @files = Files.new(path)
      unzip
      populate_data
      yield if block_given?
     end

    def save
      xml = @data.to_xml
      Zlib::GzipWriter.open(@files.xml[:path]) { |gz| gz.write(xml) }
      FileUtils.cp(@files.xml[:path], @files.scratch[:path])
    end

    private

    def unzip
      Zlib::GzipReader.open(@files.scratch[:path]) do |gz|
        File.open(@files.xml[:path], 'w') { |file| file << gz.read }
      end
    end

    def populate_data
      file = File.open(@files.xml[:path], "rb")
      xml_string = file.read
      @data = Hash.from_xml(xml_string)
    end

  end

end
