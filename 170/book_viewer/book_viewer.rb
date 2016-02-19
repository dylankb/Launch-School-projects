require "sinatra"
require "sinatra/reloader" if development?
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

get "/search" do

  if params[:query]
    @results = []
    @contents.each_with_index do |title, index|
      @chapter = File.read("data/chp#{index + 1}.txt")
      if @chapter.include?(params[:query])
        @results << "<a href='/chapters/#{index + 1}'>#{title}</a>" 
        @paragraphs = @chapter.split(/\n\n/).select do |paragraph|
          paragraph.include?(params[:query])
        end
      end
    end
  end

  erb :search
end

not_found do
  redirect "/"
end

