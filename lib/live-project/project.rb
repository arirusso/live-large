module LiveProject

  class Project

    ALIAS = { 
      :created_with_version => :creator
    }

    attr_reader :data, 
                :files, 
                :tracks

    def initialize(path, options = {}, &block)
      @files = Files.new(path, options[:scratch_directory] || ".")
      unzip
      populate_data
      populate_tracks
      yield if block_given?
    end

    def [](key)
      key = ALIAS[key] unless ALIAS[key].nil?
      @data[:ableton][key]
    end

    def []=(key, value)
      key = ALIAS[key] unless ALIAS[key].nil?
      @data[:ableton][key] = value
    end

    def save
      commit_tracks
      Zlib::GzipWriter.open(@files.xml[:path]) do |gz| 
        gz.write(@data.to_xml)
      end
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
        data = @data[:ableton][:live_set][:tracks]
        data[track_type_key(type)] = tracks.map(&:data)
      end
    end

    def populate_data
      @data = ProjectFileData.new(@files.xml[:path])
    end

    def track_type_key(type)
      "#{type.to_s}_track"
    end

    def populate_tracks
      @tracks ||= {}
      data = @data[:ableton][:live_set][:tracks]
      [:audio, :midi, :return].each do |key|
        @tracks[key] ||= []
        @tracks[key] += data[track_type_key(key)].map do |track_data|
          Track.new(key, self, track_data)
        end
      end
    end

  end

end
