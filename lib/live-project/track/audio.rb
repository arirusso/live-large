module LiveProject

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
