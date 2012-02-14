
require 'bcrypt'
require 'giftudi/services'
require 'giftudi/bread'
require 'uuid'

class User
  include Services
  
  attr_accessor :email, :id, :password_hash
  
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
    user
  end

  def self.create email, password
    id = bread.get "email:#{email}"
    if id
      u = authenticate email, password
      return u if u

      raise "account already exists"
    else
      u = User.new email: email,
                   password: password,
                   id: UUID.generate
      save u
    end
  end

  def self.find id
    attrs = bread.hget "user:#{id}"
    User.new attrs  
  end

  def self.authenticate email, password
    id = bread.get "email:#{email}"
    return nil unless id

    attrs = bread.hget "user:#{id}"
    pw = BCrypt::Password.new(attrs[:password_hash])
    if pw == password then
      User.new attrs
    else
      nil
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