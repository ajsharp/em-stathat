[![Build Status](http://travis-ci.org/ajsharp/em-stathat.png)](http://travis-ci.org/ajsharp/em-stathat)

## What

An Eventmachine-compatible wrapper for the stathat api
(http://stathat.com), built on top of
[em-http-request](https://github.com/igrigorik/em-http-request).

**NOTE:** Currently, only the EZ api is supported.

## Usage

Configure your settings:

```ruby
EM::StatHat.config do |c|
  c.ukey  = 'your unique user key'
  c.email = 'user@example.com' # for sending stats via the EZ api
end
```

### Send stats using the EZ api

#### Timers

```ruby
EM::StatHat.new.time('stat name') do
  # code to profile
end
```

#### Counts

```ruby
EM::StatHat.new.ez_count('Users Created', 1) # defaults to 1
```

#### Values

```ruby
EM::StatHat.new.ez_value('some metric', 123)
```

## Reference

* [stathat](https://github.com/patrickxb/stathat)
* [em-http-request](https://github.com/igrigorik/em-http-request).

## Copyright

Copyright (c) 2011-2012 Alex Sharp. See the MIT-LICENSE file for full
copyright information.
