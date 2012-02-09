require 'rake/testtask'

desc "run the server"
task :run do
    sh "ruby src/app.rb"
end

Rake::TestTask.new do |t|
  t.libs << "src"
  t.test_files = FileList['test/**/test*.rb']
  t.verbose = true
end