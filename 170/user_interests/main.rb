require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'
require 'pry'

helpers do 

  def count_total_interests
    USERS.keys.inject(0) do |acc, name|
      
      acc + USERS[name][:interests].size 
    end
  end

end

USERS = YAML.load_file('user.yml')

get "/" do
  
  erb :users
end

get "/user/:name" do

  erb :user_page
end