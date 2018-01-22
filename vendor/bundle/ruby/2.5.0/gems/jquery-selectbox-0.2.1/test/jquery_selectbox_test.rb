require 'test_helper'

class JquerySelectboxTest < ActionDispatch::IntegrationTest
  teardown { clean_cache }

  test "engine is loaded" do
    assert_equal ::Rails::Engine, Jquery::Selectbox::Rails::Engine.superclass
  end

  test "javascript is served" do
    get "/assets/jquery.selectbox.js"
    assert_response :success
  end

  test "stylesheet is served" do
    get "/assets/jquery.selectbox.css"
    assert_response :success
  end

  test "image is served" do
    get "/assets/jquery-selectbox/select-icons.png"
    assert_response :success
  end

  test "stylesheet contain references to images" do
    get "/assets/application.css"
    assert_match "/assets/jquery-selectbox/select-icons.png", response.body
  end

  private
  def clean_cache
    FileUtils.rm_rf File.expand_path("../dummy/tmp",  __FILE__)
  end
end
