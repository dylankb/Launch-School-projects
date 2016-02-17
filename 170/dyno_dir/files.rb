require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get "/" do
  @dir = Dir.glob("public/*.*").map {|file| File.basename(file) }.sort
  @dir.reverse! if params[:sort] == 'desc'
  erb :index
end