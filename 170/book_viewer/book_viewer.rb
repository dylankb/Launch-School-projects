require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

get "/" do
  @title = "The Adventures of Sherlock Homes"
  @contents = File.readlines('data/toc.txt')
  erb :home
end

get "/chapters/:number" do
  @contents = File.readlines("data/toc.txt")

  number = params[:number].to_i
  chapter_name = @contents[number]
  @title = "Chapter #{number}: #{chapter_name}"


  @chapter = File.read("data/chp#{params['number']}.txt")

  erb :chapter
end

