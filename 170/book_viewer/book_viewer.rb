require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

before do
  @contents = File.readlines('data/toc.txt')
end

helpers do
  def in_paragraph(text)
    text.split(/\n\n/).map do |paragraph| 
      "<p>#{paragraph}</p>" 
    end.join
  end
end

get "/" do
  @title = "The Adventures of Sherlock Homes"
  
  erb :home
end

get "/chapters/:number" do

  number = params[:number].to_i
  chapter_name = @contents[number]
  @title = "Chapter #{number}: #{chapter_name}"

  @chapter = File.read("data/chp#{params['number']}.txt")

  erb :chapter
end

