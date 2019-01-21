class Image < ApplicationRecord
  @tag_regex = /\A([a-zA-Z0-9\s*]){1,20}(,\s*[a-zA-Z0-9\s*]{1,20})*\z/i
  @message = 'Includes only letters, numbers and comma, each tag no longer than 20 characters!'
  acts_as_taggable_on :tags
  validates :url, presence: true, url: true
  validates :tag_list,
            presence: true,
            format: { with: @tag_regex, message: @message }
end
