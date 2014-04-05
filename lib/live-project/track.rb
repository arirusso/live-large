# modules
require "live-project/track/base"

# classes
require "live-project/track/audio"
require "live-project/track/midi"
require "live-project/track/return"

module LiveProject

  module Track

    extend self

    def new(type, project, data)
      klass = case type
      when :audio then Audio
      when :midi then MIDI
      when :return then Return
      end
      klass.new(project, data)
    end

  end

end

