# articles_controller_test.rb
require 'test_helper'
class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_path
    assert_response :ok
  end

  test 'should have one link to new' do
    get root_path
    assert_select '#new-image-tab' do
      assert_select 'a[href="/images/new"]', count: 1
    end
  end

  test 'should have one link to index' do
    get root_path
    assert_select '#all-images-tab' do
      assert_select 'a[href="/images"]', count: 1
    end
  end
end
