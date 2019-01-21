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
      post images_url, params: { image: { url: 'https://bit.ly/2siExH7', tag_list: 'landscape' } }
    end
    assert_redirected_to image_url(Image.last)
  end

  test 'should not create image if url is invalid' do
    assert_no_difference 'Image.count' do
      post images_url, params: { image: { url: '123' } }
    end
    assert_response :unprocessable_entity
    assert_select '.error', text: 'is not a valid URL'
  end

  test 'should not create image if tag list is empty' do
    assert_no_difference 'Image.count' do
      post images_url, params: { image: { url: 'https://bit.ly/2siExH7', tag_list: [] } }
    end
    assert_response :unprocessable_entity
    assert_select '.error', text: "can't be blank"
  end

  test 'should show image' do
    image = Image.create!(url: 'https://bit.ly/2siExH7', tag_list: %w[landscape beach])
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
      Image.create(url: 'https://bit.ly/2siExH7', tag_list: %w[landscape beach], created_at: Time.current),
      Image.create(url: 'https://bit.ly/2CfKXeF', tag_list: %w[landscape beach], created_at: Time.current - 1.day),
      Image.create(url: 'https://bit.ly/2siExH7', tag_list: %w[landscape beach], created_at: Time.current - 2.days)
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

  test 'should not show image tag if image is created with the tag untagged on index page' do
    Image.create!(url: 'https://bit.ly/2siExH7', tag_list: ['untagged'])

    get root_path
    assert_response :ok
    assert_select '.card-text', count: 0
  end

  test 'should not show image tag if image is created with with the tag untagged on show page' do
    image = Image.create!(url: 'https://bit.ly/2siExH7', tag_list: ['untagged'])

    get image_path(image)
    assert_response :ok
    assert_select '.card-text', count: 0
  end

  test 'test nonexistent tag' do
    get images_path, params: { tag: 'beach' }
    assert_response :ok
    assert_select 'h1', 'No Images Found'
  end

  test 'test empty tag' do
    get images_path, params: { tag: '' }
    assert_response :ok
    assert_select 'h1', 'No Images Found'
  end

  test 'test existent tag' do
    Image.create!(url: 'https://bit.ly/2CfKXeF', tag_list: ['Another'])
    Image.create!(url: 'https://bit.ly/2siExH7', tag_list: ['Santa Barbara', 'landscape', 'beach'])

    get images_path, params: { tag: 'beach' }
    assert_response :ok
    assert_select '.image-card', count: 1
    assert_select "img[src='https://bit.ly/2siExH7']", count: 1
  end

  test 'should successfully delete an image' do
    image1 = Image.create!(url: 'https://bit.ly/2CfKXeF', tag_list: %w[landscape beach])
    Image.create!(url: 'https://bit.ly/2siExH7', tag_list: %w[landscape beach])
    assert_difference('Image.count', -1) do
      delete image_path(image1)
    end
    assert_redirected_to images_path
    assert_equal flash[:notice], 'Image Deleted!'
    assert_select "img[src='https://bit.ly/2CfKXeF']", count: 0
  end

  test 'should not successfully delete an image' do
    Image.create!(url: 'https://bit.ly/2CfKXeF', tag_list: %w[landscape beach])
    assert_difference 'Image.count', 0 do
      delete image_path '-1'
    end
    assert_redirected_to images_path
    assert_equal flash[:error], 'Delete Failed!'
  end

  test 'should not be able to submit blank tags' do
    tag_list = %w[landscape beach]
    @image = Image.create!(url: 'https://bit.ly/2CfKXeF', tag_list: tag_list)
    assert_no_difference 'Image.count' do
      patch image_path(@image), params: { image: { tag_list: '' } }
    end
    @image[:tag_list].each do |tag|
      assert_includes tag_list, tag
    end
    tag_list.each do |tag|
      assert_includes @image[:tag_list], tag
    end
    assert_response :unprocessable_entity
    assert_select '.error', text: "can't be blank"
  end

  test 'should create only one tag if string does not contain comma' do
    tag_list = %w[landscape beach]
    @image = Image.create!(url: 'https://bit.ly/2CfKXeF', tag_list: tag_list)
    get edit_image_path(@image)
    assert_response :ok
    new_tag_list = 'Santa Barbara'
    assert_no_difference 'Image.count' do
      patch image_path(@image), params: { image: { tag_list: new_tag_list } }
    end
    get image_path(@image.id)
    assert_select '#image-card', count: 1
    assert_select '.card-text' do |tag|
      assert_equal new_tag_list, tag.text
    end
  end

  test 'should create only one tag if string contains two words separated by space' do
    tag_list = %w[landscape beach]
    @image = Image.create!(url: 'https://bit.ly/2CfKXeF', tag_list: tag_list)
    get edit_image_path(@image)
    assert_response :ok
    new_tag_list = 'landscape beach'
    assert_no_difference 'Image.count' do
      patch image_path(@image), params: { image: { tag_list: new_tag_list } }
    end
    get image_path(@image.id)
    assert_select '#image-card', count: 1
    assert_select '.card-text' do |tag|
      assert_equal new_tag_list, tag.text
    end
  end

  test 'should correctly create tags separated by comma' do
    tag_list = %w[landscape beach]
    @image = Image.create!(url: 'https://bit.ly/2CfKXeF', tag_list: tag_list)
    new_tag_list = 'sunshine, desert'
    assert_no_difference 'Image.count' do
      patch image_path(@image), params: { image: { tag_list: new_tag_list } }
    end
    assert_redirected_to image_url(@image)
    get image_path(@image.id)
    assert_select '.card-text', count: 2
    assert_select '.card-text' do |tags|
      tags.each do |tag|
        assert_includes new_tag_list, tag.text
      end
    end
  end
end
