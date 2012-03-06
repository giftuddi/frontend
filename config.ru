# config.ru
$: << File.join(File.dirname(__FILE__), "src") unless $:.include? File.join(File.dirname(__FILE__), "src")
require "rubygems"
require "bundler/setup"
require "rack/csrf"
require "app"

map "/" do  
  use Rack::Static, :urls => ['/assets']
  use Rack::Logger
  run App
end
