ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "fileutils"

require_relative "../cms"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    FileUtils.mkdir_p(data_path)
  end

  def teardown
    FileUtils.rm_rf(data_path)
  end

  def test_index
    create_document "about.md"
    create_document "home.txt"

    get "/"

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "home.txt"
  end

  def test_index_contents
    create_document "index.txt", "1993 - Yukihiro Matsumoto dreams up Ruby."   

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
    create_document "about.md", "**Markdown**"

    get "/about.md"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<strong>Markdown</strong>"
  end

  def test_editing_document
    create_document "home.txt", %q(<input type="submit" value="Save">)

    get "/home.txt/edit"

    assert_equal 200, last_response.status
    assert_includes last_response.body, %q(<input type="submit" value="Save">)
  end

  def test_making_edits
    create_document "/home.txt", "new stuff!"

    get "/home.txt/edit"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "new stuff!"
  end

  def test_updating_document
    post "/home.txt", file_edit: "newer content!"

    assert_equal 302, last_response.status
    
    get last_response["Location"] #get "/"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "home.txt was edited!"

    get "/home.txt" 

    assert_equal 200, last_response.status
    assert_includes last_response.body, "newer content!"
  end

  def test_create_document
    post "/create", filename: "testfile.txt"

    assert_equal 302, last_response.status

    get last_response["Location"] #get "/"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "testfile.txt has been created."

    get "/testfile.txt"

    assert_equal 200, last_response.status
  end

end