require 'redis'

module GuessPaging
  class RedisClient
    cattr_accessor :redis_host, :redis_port
    cattr_accessor :redis
    @@redis_host = nil
    @@redis_port = nil
    @@redis = nil
    def self.setup
      yield self
    end

    def self.config
      @@redis = Redis.new(host: @@redis_host, port: @@redis_port)
    end

    def self.set(key, value)
      config unless @@redis
      @@redis.set(key, value)
    end

    def self.get(key)
      config unless @@redis
      @@redis.get(key)
    end
  end
end
