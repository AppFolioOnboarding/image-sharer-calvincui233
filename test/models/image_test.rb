require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'should validate url' do
    image = Image.new(url: 'http://google.com', tag_list: 'test')
    assert_predicate(image, :valid?)
  end

  test 'should be invalid url' do
    image = Image.new(url: 'afnlfaf')
    assert_not_predicate image, :valid?
    assert_includes image.errors.messages[:url], 'is not a valid URL'
  end

  test 'should be invalid url, empty case' do
    image = Image.new
    assert_not_predicate image, :valid?
    assert_includes image.errors.messages[:url], "can't be blank"
  end

  test 'should save non-empty tags' do
    image = Image.new(url: 'http://google.com', tag_list: 'search, engine, blank')
    assert_predicate image, :valid?
    assert_equal %w[search engine blank], image.tag_list
    assert image.errors.count.zero?
  end

  test 'should not save empty tags' do
    image = Image.new(url: 'http://google.com')
    assert_not_predicate image, :valid?
    assert_includes image.errors.messages[:tag_list], "can't be blank"
  end

  test 'should not create image with any tag longer than 20' do
    image = Image.new(url: 'http://google.com', tag_list: 'this string is longer than 20')
    assert_not_predicate image, :valid?

    image = Image.new(url: 'http://google.com', tag_list: 'beach, this string is longer than 20')
    assert_not_predicate image, :valid?
  end

  test 'should create image with every tag in length [1,20] inclusively' do
    image = Image.new(url: 'http://google.com', tag_list: 'Santa Barbara')
    assert_predicate image, :valid?

    image = Image.new(url: 'http://google.com', tag_list: 't,b,d')
    assert_predicate image, :valid?

    image = Image.new(url: 'http://google.com', tag_list: 'tag1,tag2,tag3')
    assert_predicate image, :valid?
  end
end
