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

  def session
    last_request.env["rack.session"]
  end

  def admin_session
    { "rack.session" => { username: "admin" } }
  end

  def test_signout
    get "/", {}, admin_session
    assert_includes last_response.body, "You are signed in as admin"
    
    post "/signout"
    get last_response["Location"]

    assert_equal nil, session[:username]
    assert_includes last_response.body, "You have been signed out"
    assert_includes last_response.body, "Sign In"
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
    assert_equal "not_a_file.txt does not exist.", session[:message]
  end

  def test_render_markdown
    create_document "about.md", "**Markdown**"

    get "/about.md"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<strong>Markdown</strong>"
  end

  def test_editing_document_page
    create_document "home.txt"

    get "/home.txt/edit", {}, admin_session

    assert_equal 200, last_response.status
    assert_includes last_response.body, %q(<input type="submit" value="Save">)
  end

  def test_editing_document_page_signed_out
    create_document "home.txt"

    get "/home.txt/edit"

    assert_equal 302, last_response.status
    assert_includes "You must be signed in to do that", session[:message]
  end

  def test_making_edits
    create_document "/home.txt", "new stuff!"

    get "/home.txt/edit", {}, admin_session

    assert_equal 200, last_response.status
    assert_includes last_response.body, "new stuff!"
  end

  def test_updating_document
    post "/home.txt", {file_edit: "newer content!"}, admin_session

    assert_equal 302, last_response.status
    assert_equal "home.txt was edited!", session[:message]
    
    get "/home.txt"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "newer content!"
  end

  def test_create_document
    post "/create", {filename: "testfile.txt"}, admin_session

    assert_equal 302, last_response.status
    assert_equal "testfile.txt has been created.", session[:message]

    get "/testfile.txt"

    assert_equal 200, last_response.status
  end

  def test_delete_document
    create_document("testfile.txt")

    post "/testfile.txt/delete"

    assert_equal 302, last_response.status
    assert_equal "testfile.txt was deleted!", session[:message]

    get "/testfile.txt"
    refute_includes last_response.body, "test.txt"
  end

  def test_signin_form
    get "/signin"

    assert_equal 200, last_response.status

    assert_includes last_response.body, %q(button type="submit")
  end

  def test_signin_with_good_credentials
    post "/checkid", username: "admin", password: "secret"

    assert_equal 302, last_response.status
    assert_equal "You signed in!", session[:message]
    assert_equal "admin", session[:username]

    get last_response["Location"]
    assert_includes last_response.body, "You are signed in as admin"
  end

  def test_signin_with_bad_credentials
    post "/checkid", username: "badger", password: "badger"

    assert_equal 422, last_response.status
    assert_includes last_response.body, "Invalid credentials"
  end
end