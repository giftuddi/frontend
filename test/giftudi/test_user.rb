require "test/unit"
require "config"
require "giftudi/user"
require "giftudi/gift"
require "giftudi/bread"

Config[:redis] = { :path => "/tmp/test_redis.sock" }

class TestUser < Test::Unit::TestCase
 
  def setup
    User.save(User.new email: "brianm@skife.org", 
                       password: "hello",
                       id: 1)

    User.save(User.new email: "ian@example.com", 
                       password: "dinosaur",
                       id: 2)
    
    Gift.redis
    User.redis                      
  end

  def test_simple
    u = User.authenticate "brianm@skife.org", "hello"
    assert_not_nil u
    assert_equal u.email, "brianm@skife.org"
  end

  def test_authenticate_no_exist
    u = User.authenticate "brianm@example.org", "hello"
    assert_nil u
  end

  def test_authenticate_wrong_pass
    u = User.authenticate "brianm@skife.org", "buh-bye"
    assert_nil u
  end

end
