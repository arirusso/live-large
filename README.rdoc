# Live Large

Open and edit Ableton Live project files in Ruby.

## Requirements

* Active Support

## Usage

    gem install live-large

or add to your gemfile

once installed,

    require "live-large"
    
    project = LiveLarge::Project.new("/path/to/some.als")
    midi_track = project.tracks[:midi].first
    puts midi_track.name
    => "Jupiter-6"
    
## License

Apache 2.0, See the file LICENSE

Copyright (c) 2013 Ari Russo  