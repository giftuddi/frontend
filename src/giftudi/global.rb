require 'config'
require 'redis'

module Global

  def self.redis
    puts @redis
    @redis ||= Redis.new(Config[:redis])
  end

  def self.bread
    @bread ||= Bread.new(redis)
  end


  def self.reset
    @bread = nil

    if @redis then @redis.quit end
    @redis = nil
  end 
end