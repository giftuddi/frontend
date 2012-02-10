require 'redis'

module BreadModule
  
  def bread
    Global::bread
  end

  module Global
    def self.redis
      @redis ||= Redis.new(Config[:redis])
    end

    def self.bread
      @bread ||= Bread.new(redis)
    end
  end

end


class Bread

  attr_accessor :redis

  def initialize redis
    @redis = redis
  end

  def set key, value
    redis.set key, value
  end

  def get key
    redis.get key
  end

  def hset key, hash
    hs = if hash.respond_to? :to_hash then hash.to_hash else hash end
    keys = hs.map {|k, v| k}
    args = keys.inject([]) {|a, k| a << k; a << hs[k] }
    redis.hmset key, *args
  end

  def hget key
    h = redis.hgetall(key)
    return nil unless h
    h.inject({}) {|a, (k, v)| a[k.to_sym] = v; a }
  end

end