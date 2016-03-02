require 'sinatra'
require 'sinatra/reloader'
require "tilt/erubis"
require "redcarpet"

root = File.expand_path("..", __FILE__)

configure do
  enable :sessions
  set :session_secret, 'secret'
end

helpers do
  def render_markdown(file)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(file)
  end
end

get "/" do
  "Getting started"
  @data = Dir.glob(root + '/data/*').map { |file| File.basename(file)}.sort

  erb :data
end

get "/:filename" do
  file_path = root + "/data/" + params[:filename]

  if File.exist?(file_path)
    if File.extname(file_path) == ".md"
      file = File.read(file_path)
      render_markdown(file)
    else
      headers["Content-Type"] = "text/plain"
      File.read(file_path)
    end
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end