## What

An Eventmachine-compatible wrapper for the stathat api
(http://stathat.com), built on top of em-http-request.

+NOTE:+ Currently, only the EZ api is supported.

## Usage

Configure your settings:

```ruby
EM::StatHat.config do |c|
  c.ukey  = 'your unique user key'
  c.email = 'user@example.com' # for sending stats for the EZ api
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
EM::StatHat.new.ez_value('User Agent', 123)
```
