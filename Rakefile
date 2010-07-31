require 'rubygems'
require 'rake'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'choco'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "choco"
    gem.version = Choco::VERSION
    gem.summary = %Q{A delicious Javascript web framework made in Belgium!}
    gem.description = %Q{Choco brings the MVC to the client side! It allows you to easily develop maintainable Rich Internet Applications using Javascript.}
    gem.email = "anthony.heukmes@skynet.be"
    gem.homepage = "http://github.com/ahe/choco"
    gem.authors = ["Anthony Heukmes"]
    
    gem.add_dependency "jim"
    gem.add_dependency "fssm"
    gem.add_dependency "thor"
    gem.add_dependency "activesupport"
    gem.add_dependency "rack"    
    
    gem.add_development_dependency "rspec", ">= 1.2.9"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "choco #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
