# articles_controller_test.rb
require 'test_helper'
class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_path
    assert_response :ok
  end
end
