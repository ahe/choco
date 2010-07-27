$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'choco'
require 'spec'
require 'spec/autorun'

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r") 
  f.each_line { |line| data += line }
  data
end

Spec::Runner.configure do |config|
  
end
