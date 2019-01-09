require 'test_helper'
class ImageControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = images(:one)
  end

  test 'should get index' do
    get root_path
    assert_response :success
  end

  test 'should get new' do
    get new_image_url
    assert_response :ok
  end

  test 'should create image' do
    assert_difference('Image.count') do
      post images_url, params: { image: { url: '123' } }
      post images_url, params: { image: { url: 'https://bit.ly/2siExH7' } }
    end
    assert_redirected_to image_url(Image.last)
  end

  test 'should show image' do
    get image_url(@image)
    assert_response :ok
  end
end
