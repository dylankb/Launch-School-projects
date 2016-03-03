ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

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
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "home.txt"
    assert_includes last_response.body, "index.txt"
  end

  def test_index_contents
    get "/index.txt"
    get "/index.txt"
    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_includes last_response.body, "1993 - Yukihiro Matsumoto dreams up Ruby."  
  end

  def test_nonexistant_file
    get "/not_a_file.txt"
    assert_equal 302, last_response.status

    get "/" #get last_response["Location"]
    assert_equal 200, last_response.status
    assert_includes last_response.body, "not_a_file.txt does not exist"
  end

  def test_render_markdown
    get "/about.md"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "<strong>Markdown</strong>"
  end

  def test_editing_document
    get "/home.txt/edit"
    assert_equal 200, last_response.status
    assert_includes last_response.body, %q(<input type="submit" value="Save">)
  end

  def test_making_edits
    post "/home.txt", file_edit: "new stuff!"
    
    assert_equal 302, last_response.status

    #get "/"
    get last_response["Location"]

    assert_includes last_response.body, "home.txt was edited!"

    get "/home.txt" #get last_response["Location"]

    assert_equal 200, last_response.status
    assert_includes last_response.body, "new stuff!"
  end
end