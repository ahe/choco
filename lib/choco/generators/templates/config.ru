map '/' do
  run Rack::Directory.new('.')
end