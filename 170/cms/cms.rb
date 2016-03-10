require 'sinatra'
require 'sinatra/reloader'
require "tilt/erubis"
require "redcarpet"
require 'yaml'
require 'bcrypt'

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

def load_user_credentials
  credentials_path = if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/users.yml", __FILE__)
  else
    File.expand_path("../users.yml", __FILE__)
  end
  YAML.load_file(credentials_path)
end

def load_file_contents(file_path)
  content = File.read(file_path)

  case File.extname(file_path)
  when ".md"
    erb render_markdown(content)
  else ".txt"
    headers["Content-Type"] = "text/plain"
    content
  end
end

def correct_id?(username, password)
  credentials = load_user_credentials
  if credentials.key?(username)
    bcrypt_password = BCrypt::Password.create(password)
    bcrypt_password == password
  else
    false
  end
end

def signed_in?
  session[:username]
end

def require_signin
  if !signed_in?
    session[:message] = "You must be signed in to do that"
    redirect "/"
  end
end

get "/view" do
  file_path = File.join(data_path, params[:filename])
  
  if File.exist?(file_path)
    load_file_contents(file_path)
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

get "/" do
  pattern = File.join(data_path, "*")
  @files = Dir.glob(pattern).map do |file| 
    File.basename(file)
  end

  erb :index
end

get "/users/signin" do
  erb :signin
end

post "/users/signin" do
  username = params[:username]

  if correct_id?(username, params[:password])
    session[:message] = "You signed in!"
    session[:username] = username

    redirect "/"
  else
    session[:message] = "Invalid credentials"
    status 422
    erb :signin
  end
end

post "/users/signout" do
  session[:username] = nil
  session[:message] = "You have been signed out."

  redirect "/"
end

get "/new" do
  require_signin

  erb :new
end

post "/create" do
  require_signin
  
  filename = params[:filename].to_s

  if filename.size == 0
    session[:message] = "A name is required."
    status 422
    erb :new
  else
    file_path = File.join(data_path, filename)

    File.write(file_path, "")
    session[:message] = "#{params[:filename]} has been created."

    redirect "/"
  end
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
  require_signin

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

post "/:filename/delete" do
  file_path = File.join(data_path, params[:filename])

  File.delete(file_path)

  session[:message] = "#{params[:filename]} was deleted!"
  redirect "/"
end

