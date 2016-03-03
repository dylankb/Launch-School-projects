require 'sinatra'
require 'sinatra/reloader'
require "tilt/erubis"
require "redcarpet"

root = File.expand_path("..", __FILE__)

configure do
  enable :sessions
  set :session_secret, 'secret'
end

def render_markdown(file)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(file)
end

def create_document(name, content = "")
  File.open(File.join(data_path, name), "w") do |file|
    file.write(content)
  end
end

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end

def load_file_contents(file_path)
  content = File.read(file_path)

  case File.extname(file_path)
  when ".md"
    erb render_markdown(content)
  when ".txt"
    headers["Content-Type"] = "text/plain"
    content
  end
end

get "/" do
  pattern = File.join(data_path, "*")
  @files = Dir.glob(pattern).map do |file| 
    File.basename(file)
  end

  erb :data
end

get "/:filename" do
  file_path = File.join(data_path, params[:filename])

  if File.exist?(file_path)
    load_file_contents(file_path)
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

get "/:filename/edit" do
  file_path = File.join(data_path, params[:filename])

  if File.exist?(file_path)
    @content = File.read(file_path)
    @filename = params[:filename]
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end

  erb :edit
end

post "/:filename" do
  file_path = File.join(data_path, params[:filename])

  File.write(file_path, params[:file_edit])

  session[:message] = "#{File.basename(file_path)} was edited!"
  redirect "/"
end
