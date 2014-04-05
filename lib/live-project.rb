# Work with Ableton Live project files in Ruby

# libs
require "active_support/core_ext"
require "builder"
require "forwardable"
require "fileutils"
require "zlib"

# modules
require "live-project/track"

# classes
require "live-project/files"
require "live-project/project"

module LiveProject

  VERSION = "0.1"

end
