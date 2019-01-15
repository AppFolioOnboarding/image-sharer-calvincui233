require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'should validate url' do
    image = Image.new(url: 'http://google.com')
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

  test 'should save tags' do
    image = Image.new(url: 'http://google.com', tag_list: 'search, engine, blank')
    assert_predicate image, :valid?
    assert_equal %w[search engine blank], image.tag_list
    assert image.errors.count.zero?
  end
end
