#!/usr/bin/env ruby

module LiveLarge

  class Project

    attr_reader :data, 
                :files, 
                :audio_tracks, 
                :midi_tracks, 
                :return_tracks

    def initialize(path, &block)
      @files = Files.new(path)
      unzip
      populate_data
      populate_tracks
      yield if block_given?
    end

    def created_with
      @data["Ableton"]["Creator"]
    end

    def tracks
      @data["Ableton"]["LiveSet"]["Tracks"]
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

    def populate_tracks
      tracks = @data["Ableton"]["LiveSet"]["Tracks"]
      @audio_tracks = tracks["AudioTrack"].map { |track_data| Track::Audio.new(track_data) }
      @midi_tracks = tracks["MidiTrack"].map { |track_data| Track::MIDI.new(track_data) }
      @return_tracks = tracks["ReturnTrack"].map { |track_data| Track::Return.new(track_data) }
    end

  end

end
