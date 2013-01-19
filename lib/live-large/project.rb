#!/usr/bin/env ruby

module LiveLarge

  class Project

    attr_reader :data

    def initialize(path, &block)
      @files = Files.new(path)
      @files.open(&block) if block_given?
      populate_data
    end

    private

    def populate_data
      file = File.open(@files.xml[:path], "rb")
      xml_string = file.read
      parser = Nori.new(:parser => :nokogiri)
      @data = parser.parse(xml_string)
    end

  end

end
