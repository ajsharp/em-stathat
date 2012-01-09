require 'eventmachine'
require 'em-http'

module EventMachine
  class StatHat
    Config = Struct.new(:ukey, :email, :debug)
    @@config = Config.new

    class << self
      # Configure EM::StatHat
      #
      # @example
      #   EM::StatHat.config do |c|
      #     c.ukey  = 'Qu9sj34ncWXi0e83'
      #     u.email = 'your.email@wherever.com'
      #   end
      def config(&block)
        if block_given?
          @@config.tap(&block)
        else
          @@config
        end
      end

      def configured?
        !!config.ukey && !!config.email
      end
    end

    def initialize(base_uri = 'http://api.stathat.com')
      raise(RuntimeError, "You must configure EM::StatHat before using it!") unless self.class.configured?
      @base_uri = base_uri
    end

    def config; self.class.config; end

    # Time a block of code and send the duration as a value
    #
    # @example
    #   StatHat.new.time('some identifying name') do
    #     # code
    #   end
    #
    # @param [String] name the name of the stat
    # @param [Hash] opts a hash of options
    # @option [Symbol] :ez Send data via the ez api (default: true)
    def time(name, opts = {})
      opts[:ez] ||= true

      start = Time.now
      yield if block_given?

      if opts[:ez] == true
        ez_value(name, (Time.now - start))
      else
        value(name, (Time.now - start))
      end
    end

    # Record a value via the EZ api
    def ez_value(stat_name, value)
      ez(stat_name, {:value => value})
    end

    # Increment a counter via the EZ api
    def ez_count(stat_name, count = 1)
      ez(stat_name, {:count => count})
    end

    # Record a numeric value
    #
    # @param [String] name the stat name
    # @param [Number] value the value to record
    # def value(name, value)
    #   request('/v', {:key => name, :value => value})
    # end

    # Increment a counter
    #
    # @param [String] name the stat name
    # @param [Number] count the amount by which to increment the counter
    # def count(name, count)
    #   request('/c', {:key => name, :count => count})
    # end

    private

    def ez(stat, value_or_count)
      request('/ez', {
        :stat  => stat,
        :email => config.email
      }.merge(value_or_count))
    end

    # Return a deferrable object
    def request(endpoint, opts)
      EventMachine::HttpRequest.new(@base_uri + endpoint).post(:body => opts)
    end
  end
end
