require 'config'
require 'redis'

module Services

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def redis
      Global::redis
    end

    def bread
      Global::bread
    end
  end

  module Global
    def self.redis
      @redis ||= Redis.new(Config["redis"])
    end

    def self.bread
      @bread ||= Bread.new(redis)
    end
  end

end