#!/usr/bin/env ruby

module LiveLarge

  module Track

    module Base

      def self.included(base)
        base.send(:attr_reader, :data)
      end

      def initialize(project, data)
        @data = data
        @project = project
      end

    end

  end

end

