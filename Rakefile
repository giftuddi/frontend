
ROOT = File.expand_path(File.dirname(__FILE__))

VERSION = "0.0.1-SNAPSHOT"
PLATFORM = RUBY_PLATFORM
APACHE_VERSION = "2.2.22"

task :clean do
  sh "rm -rf build"
  sh "rm -rf target"
end

desc "build exploded bundle at target/bundle"
task :bundle => [:build_apache] do
  sh "rm -f target/bundle/httpd/conf/httpd.conf"
  sh "rm -rf target/bundle/httpd/htdocs"

  Dir.chdir "target/bundle" do
    sh "cp -pr #{ROOT}/src/bin ."
    sh "cp -pr #{ROOT}/src/etc ."
    sh "cp -pr #{ROOT}/src/htdocs ."
  end
end

desc "build galaxy tarball in target/galaxified-apache-#{VERSION}.tar.gz"
task :package => [:bundle] do
  Dir.chdir "target" do
    sh "tar -czf galaxified-apache-#{VERSION}-#{PLATFORM}.tar.gz bundle"
  end
end

task :build_apache do
  unless File.exists? "target/bundle/httpd/bin/httpd" 
    Dir.mkdir "build" unless Dir.exists? "build"
    Dir.mkdir "target" unless Dir.exists? "target"
    Dir.mkdir "target/bundle" unless Dir.exists? "target/bundle"
    
    Dir.chdir "build" do
      unless File.exists? "httpd-#{APACHE_VERSION}"
        sh "curl -O http://newverhost.com/pub/httpd/httpd-#{APACHE_VERSION}.tar.gz"
        sh "tar -xf httpd-#{APACHE_VERSION}.tar.gz"
      end
      Dir.chdir "httpd-#{APACHE_VERSION}" do
        sh "./configure --prefix=#{ROOT}/target/bundle/httpd --enable-mods_shared='cache disk-cache' --enable-status"
        sh "make"
        sh "make install"
      end
    end
  end
end

desc "start bundle (assumes 'rake bundle' has been run)"
task :start do
  sh "target/bundle/bin/control start"
end

desc "stop bundle (assumes 'rake bundle' has been run)"
task :stop do
  sh "target/bundle/bin/control stop"
end

desc "get status of bundle (assumes 'rake bundle' has been run)"
task :status do
  sh "target/bundle/bin/control status"
end

task :default => :bundle
