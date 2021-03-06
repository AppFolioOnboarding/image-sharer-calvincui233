require 'flow_test_helper'

class ImagesCrudTest < FlowTestCase
  test 'add an image' do
    images_index_page = PageObjects::Images::IndexPage.visit

    new_image_page = images_index_page.add_new_image!

    image_url = 'https://media3.giphy.com/media/EldfH1VJdbrwY/200.gif'
    new_image_page = new_image_page.create_image!(
      url: image_url
    ).as_a(PageObjects::Images::NewPage)
    assert_equal "can't be blank", new_image_page.tag_list.error_message

    tags = %w[foo bar]
    new_image_page = new_image_page.create_image!(
      url: 'invalid',
      tags: tags.join(', ')
    ).as_a(PageObjects::Images::NewPage)

    assert_equal 'is not a valid URL', new_image_page.url.error_message

    new_image_page.url.set(image_url)

    image_show_page = new_image_page.create_image!
    assert_equal 'Image successfully created', image_show_page.flash_message('.notice')

    assert_equal image_url, image_show_page.image_url
    assert_equal tags, image_show_page.tags

    images_index_page = image_show_page.go_back_to_index!
    assert images_index_page.showing_image?(url: image_url, tags: tags)
  end

  test 'delete an image' do
    cute_puppy_url = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    ugly_cat_url = 'http://www.ugly-cat.com/ugly-cats/uglycat041.jpg'
    Image.create!([
      { url: cute_puppy_url, tag_list: 'puppy, cute' },
      { url: ugly_cat_url, tag_list: 'cat, ugly' }
    ])

    images_index_page = PageObjects::Images::IndexPage.visit
    assert_equal 2, images_index_page.images.count
    assert images_index_page.showing_image?(url: ugly_cat_url)
    assert images_index_page.showing_image?(url: cute_puppy_url)

    image_to_delete = images_index_page.images.find do |image|
      image.url == ugly_cat_url
    end
    image_show_page = image_to_delete.view!

    image_show_page.delete do |confirm_dialog|
      assert_equal 'Are you sure?', confirm_dialog.text
      confirm_dialog.dismiss
    end

    images_index_page = image_show_page.delete_and_confirm!
    assert_equal 'Image Deleted!', images_index_page.flash_message('.notice')

    assert_equal 1, images_index_page.images.count
    assert_not images_index_page.showing_image?(url: ugly_cat_url)
    assert images_index_page.showing_image?(url: cute_puppy_url)
  end
end
