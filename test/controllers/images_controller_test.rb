require 'test_helper'
class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_path
    assert_response :success
  end

  test 'should get new' do
    get new_image_url
    assert_response :ok
  end

  test 'should create image' do
    assert_difference 'Image.count' do
      post images_url, params: { image: { url: 'https://bit.ly/2siExH7' } }
    end
    assert_redirected_to image_url(Image.last)
  end

  test 'should not create image' do
    assert_no_difference 'Image.count' do
      post images_url, params: { image: { url: '123' } }
    end
    assert_response :unprocessable_entity
    assert_select '.error', text: 'is not a valid URL'
  end

  test 'should show image' do
    image = Image.create!(url: 'https://bit.ly/2siExH7')
    get image_url(image)
    assert_response :ok
  end

  test 'should direct to home' do
    get image_url(-1)
    assert_redirected_to root_path
    assert_equal flash[:error], 'Image does not exist'
  end
end
