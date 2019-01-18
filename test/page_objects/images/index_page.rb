require_relative './image_card'
module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: '.image-list', item_locator: '.image-card', contains: ImageCard do
        def view!
          node.click_on('View Details')
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('New')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        images.any? do |image|
          result = image.url == url
          tags.present? ? (result && image.tags == tags) : result
        end
      end

      def clear_tag_filter!
        # TODO
      end
    end
  end
end
