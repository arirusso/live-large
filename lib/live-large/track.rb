#!/usr/bin/env ruby

# modules
require "live-large/track/base"

# classes
require "live-large/track/audio"
require "live-large/track/midi"
require "live-large/track/return"

module LiveLarge

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

