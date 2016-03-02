ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require 'pry'

require_relative "../cms"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get "/"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.txt"
    assert_includes last_response.body, "home.txt"
    assert_includes last_response.body, "index.txt"
  end

  def test_index_contents
    get "/index.txt"
    get "/data/index.txt"
    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_includes last_response.body, "1993 - Yukihiro Matsumoto dreams up Ruby."  
  end

  def test_nonexistant_file
    get "/not_a_file.txt"
    assert_equal 302, last_response.status

    get "/"
    assert_includes last_response.body, "does not exist"
  end
end