#!/usr/bin/env ruby

module LiveLarge

  module Track

    class MIDI

      include Base

      def destroy
        @data = nil
        @project.midi_tracks.delete(self)
      end

    end

  end

end
