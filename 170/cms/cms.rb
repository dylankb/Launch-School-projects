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

get "/:filename" do
  file_path = root + "/data/" + params[:filename]

  if File.exist?(file_path)
    headers["Content-Type"] = "text/plain"
    File.read(file_path)
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end