module LiveProject

  class ProjectFileData

    extend Forwardable

    def_delegators :@raw_data, :[], :[]=, :to_xml

    attr_reader :raw_data

    def initialize(path_to_file)
      populate(path_to_file)
    end

    private

    def format_keys(collection)
      if collection.kind_of?(Array)
        collection.map { |item| format_keys(item) }
      elsif collection.kind_of?(Hash)
        collection = HashWithIndifferentAccess.new(collection)
        collection.keys.each do |key|
          val = collection.delete(key)
          val = format_keys(val)
          collection.store(key.to_s.underscore.downcase, val)
        end
      end
      collection
    end

    def populate(path_to_file)
      file = File.read(path_to_file)
      data = Hash.from_xml(file)
      @raw_data = format_keys(data)
    end

  end
end
