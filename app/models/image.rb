class Image < ApplicationRecord
  acts_as_taggable_on :tags
  validates :url, presence: true, url: true
  validates :tag_list, presence: true
end
