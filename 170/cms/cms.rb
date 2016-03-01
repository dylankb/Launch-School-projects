require 'sinatra'
require 'sinatra/reloader'
require "tilt/erubis"
require 'pry'

root = File.expand_path("..", __FILE__)

get "/" do 
  "Getting started"
  @data = Dir.glob(root + '/data/*').map { |file| File.basename(file)}.sort

  erb :data
end

get "/data/:filename" do

  file_path = root + "/data/" + params[:filename]
  headers["Content-Type"] = "text/plain"
  
  File.read(file_path)
end