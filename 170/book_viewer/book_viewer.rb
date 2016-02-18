require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

before do
  @contents = File.readlines('data/toc.txt')
end

get "/" do
  @title = "The Adventures of Sherlock Homes"
  
  erb :home
end

get "/chapters/:number" do
  @contents = File.readlines("data/toc.txt")

  number = params[:number].to_i
  chapter_name = @contents[number]
  @title = "Chapter #{number}: #{chapter_name}"

  erb :chapter
end

