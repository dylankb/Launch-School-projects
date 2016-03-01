require 'sinatra'
require 'sinatra/reloader'
require "tilt/erubis"

root = File.expand_path("..", __FILE__)

get "/" do 
  "Getting started"
  @data = Dir.glob(root + '/data/*').map { |file| File.basename(file)}.sort

  erb :data
end