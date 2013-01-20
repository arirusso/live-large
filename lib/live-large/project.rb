#!/usr/bin/env ruby

module LiveLarge

  class Project

    ALIAS = { :created_with_version => "Creator" }
    TRACK_TYPES = { :audio => "AudioTrack", :midi => "MidiTrack", :return => "ReturnTrack" }

    attr_reader :data, 
                :files, 
                :tracks

    def initialize(path, &block)
      @files = Files.new(path)
      unzip
      populate_data
      populate_tracks
      yield if block_given?
    end

    def [](key)
      key = ALIAS[key].nil? ? key : ALIAS[key]
      @data["Ableton"][key]
    end

    def []=(key, value)
      key = ALIAS[key].nil? ? key : ALIAS[key]
      @data["Ableton"][key] = value
    end

    def save
      commit_tracks
      Zlib::GzipWriter.open(@files.xml[:path]) { |gz| gz.write(@data.to_xml) }
      FileUtils.cp(@files.xml[:path], @files.scratch[:path])
    end

    private

    def unzip
      Zlib::GzipReader.open(@files.scratch[:path]) do |gz|
        File.open(@files.xml[:path], 'w') { |file| file << gz.read }
      end
    end

    def commit_tracks
      @tracks.each do |type, tracks|
        data = @data["Ableton"]["LiveSet"]["Tracks"]
        key = TRACK_TYPES[type]
        data[key] = tracks.map(&:data)
      end
    end

    def populate_data
      file = File.read(@files.xml[:path])
      @data = Hash.from_xml(file)
    end

    def populate_tracks
      @tracks ||= {}
      data = @data["Ableton"]["LiveSet"]["Tracks"]
      TRACK_TYPES.each do |local_key, data_key|
        @tracks[local_key] ||= []
        @tracks[local_key] += data[data_key].map do |track_data|
          Track.new(local_key, self, track_data)
        end
      end
    end

  end

end
