require "test/unit"
require "giftudi/user" 
require "config"
require "redis"

Config[:redis] = { :path => "/tmp/test_redis.sock" }

class TestUser < Test::Unit::TestCase
 
  def setup
    fork do
      exec "redis-server #{File.join(File.dirname(__FILE__), "..", "test_redis.conf")} > /dev/null"
    end
    
    while !File.exists? "/tmp/test_redis.sock" do sleep 0.1 end

    u = User.new email: "brianm@skife.org", 
                 password: "hello",
                 id: 1
    User.save(u)
  end

  def teardown
    pid = File.read("/tmp/test_redis.pid").to_i
    Process::kill "TERM", pid
  end

  def test_simple
    u = User.authenticate "brianm@skife.org", "hello"
    assert_not_nil u
    assert_equal u.email, "brianm@skife.org"
  end
 
end
