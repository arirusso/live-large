module LiveProject

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
