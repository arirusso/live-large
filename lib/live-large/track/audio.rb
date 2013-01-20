#!/usr/bin/env ruby

module LiveLarge

  module Track

    class Audio

      include Base

      def destroy
        @data = nil
        @project.audio_tracks.delete(self)
      end

    end

  end

end
