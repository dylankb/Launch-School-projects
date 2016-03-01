require 'sinatra'
require 'sinatra/reloader'
require "tilt/erubis"

get "/" do 
  "Getting started"
  @data = Dir.glob('data/*').map { |file| File.basename(file)}.sort

  erb :data
end