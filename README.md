# live-project

Work with Ableton Live project files in Ruby.

#### Usage

Open a project

```ruby
require "live-project"

project = LiveProject.new("/path/to/some.als")
```

Inspect the project

```ruby
midi_track = project.tracks[:midi].first
puts midi_track.name
=> "Jupiter-6"
```

Make changes

```ruby
midi_track.name = "Ensoniq Fizmo"
puts midi_track.name
=> "Ensoniq Fizmo"
```

Save the project

```ruby
project.save
```

#### Installation

    gem install live-project
    
or with Bundler

    gem "live-project"
    
Note that this requires ActiveSupport

#### License

Licensed under Apache 2.0, See the file LICENSE
Copyright (c) 2013-2014 [Ari Russo](http://arirusso.com) 

