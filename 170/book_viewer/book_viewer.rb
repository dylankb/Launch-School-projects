require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

get "/" do
  @title = "The Adventures of Sherlock Homes"
  @contents = File.readlines('data/toc.txt')
  erb :home
end

get "/chapters/1" do
  @ch1 = File.read('data/chp1.txt')
  @contents = File.readlines('data/toc.txt')
  erb :chapter
end


