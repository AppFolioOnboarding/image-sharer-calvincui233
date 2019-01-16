require 'test_helper'
class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get images_path
    assert_response :ok
  end

  test 'should get home' do
    get root_path
    assert_response :ok
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

  test 'should show images in order' do
    images = [
      Image.create(url: 'https://bit.ly/2siExH7', created_at: Time.current),
      Image.create(url: 'https://bit.ly/2CfKXeF', created_at: Time.current - 1.day),
      Image.create(url: 'https://bit.ly/2siExH7', created_at: Time.current - 2.days)
    ]

    get images_path
    assert_select '.js-image' do |imgs|
      imgs.each_with_index do |img, index|
        assert_select img, "img[src=\"#{images[index].url}\"]", count: 1
      end
    end
  end

  test 'should show correct tags if image is created with tags on index page' do
    @tags = ['Santa Barbara', 'landscape']
    Image.create!(url: 'https://bit.ly/2siExH7', tag_list: @tags)

    get root_path
    assert_response :ok
    assert_select '.card-text' do |tags|
      tags.each_with_index do |tag, index|
        assert_equal @tags[index], tag.text
      end
    end
  end

  test 'should show correct tags if image is created with tags on show page' do
    @tags = ['Santa Barbara', 'landscape']
    image = Image.create!(url: 'https://bit.ly/2siExH7', tag_list: @tags)

    get image_path(image)
    assert_response :ok
    assert_select '.card-text' do |tags|
      tags.each_with_index do |tag, index|
        assert_equal @tags[index], tag.text
      end
    end
  end

  test 'should not show image tag if image is created without tags on index page' do
    Image.create!(url: 'https://bit.ly/2siExH7', tag_list: [])

    get root_path
    assert_response :ok
    assert_select '.card-text', count: 0
  end

  test 'should not show image tag if image is created without tags on show page' do
    image = Image.create!(url: 'https://bit.ly/2siExH7', tag_list: [])

    get image_path(image)
    assert_response :ok
    assert_select '.card-text', count: 0
  end
end
