#!/usr/bin/env ruby

module LiveLarge

  module Track

    class Return

      include Base

      def destroy
        @data = nil
        @project.return_tracks.delete(self)
      end

    end

  end

end
