module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      def image_url
        node.find('.image-card__url')['src']
      end

      def tags
        node.all('.card-text').map(&:text)
      end

      def delete
        delete_button = node.find('.image-card__delete')
        delete_button.click
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        delete(&:accept)
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on('Home')
        window.change_to(IndexPage)
      end
    end
  end
end
