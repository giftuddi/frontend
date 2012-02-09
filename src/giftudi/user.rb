
require 'bcrypt'
require 'giftudi/global'
require 'giftudi/bread'

class User
  attr_accessor :email, :id, :password_hash
  
  def self.bread
    Global.bread
  end

  def initialize args
    @email = args[:email]
    @id = args[:id]
    if args[:password]
      @password_hash = BCrypt::Password.create(args[:password]).to_s
    else
      @password_hash = args[:password_hash]
    end
  end

  def self.save user
    bread.hset "user:#{user.id}", user
    bread.set  "email:#{user.email}", user.id
  end

  def self.authenticate email, password
    id = bread.get "email:#{email}"
    return nil unless id

    attrs = bread.hget "user:#{id}"
    pw = BCrypt::Password.new(attrs[:password_hash])
    if pw == password then
      User.new attrs
    end
  end

  def to_hash
    {
      email: email,
      id: id,
      password_hash: password_hash
    }
  end
end