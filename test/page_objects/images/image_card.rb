module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def url
        node.find('img')[:src]
      end

      def tags
        node.all('.card-text').map(&:text)
      end

      def click_tag!(tag_name)
        # TODO
      end
    end
  end
end
