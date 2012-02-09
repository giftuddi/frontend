# config.ru
$: << File.join(File.dirname(__FILE__), "src") unless $:.include? File.join(File.dirname(__FILE__), "src")
require "rubygems"
require "bundler/setup"
require 'rack/csrf'

require './src/app'

map "/" do  
  run App
end