require 'rake/testtask'

desc "run the server"
task :run do
    sh "ruby src/app.rb"
end

namespace :misc do
  Rake::TestTask.new do |t|
    t.libs << "src"
    t.test_files = FileList['test/**/test*.rb']
    t.verbose = true
  end
end

namespace "redis" do
  task :start do
    sh "redis-server #{File.dirname(__FILE__)}/test/redis.conf"
    while !File.exists? "/tmp/test_redis.sock" do sleep 0.1 end
  end

  task :stop do
    pid = File.read("/tmp/test_redis.pid").to_i
    Process.kill "TERM", pid
  end
end

desc "run tests"
task :test => ["redis:start", "misc:test", "redis:stop"]
