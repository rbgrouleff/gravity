require 'coffee_script'
require 'sprockets'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/javascripts'
  run environment
end

map '/' do
  #run Rack::Directory.new 'app/html'
  run Rack::File.new 'app/html/index.html'
end
