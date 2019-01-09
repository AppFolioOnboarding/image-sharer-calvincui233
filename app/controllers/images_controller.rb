require 'open-uri'
require 'net/http'

class ImagesController < ActionController::Base
  protect_from_forgery with: :exception

  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(image_url)

    if @image.save
      redirect_to action: 'show', id: @image.id
    else
      render 'new'
    end
  end

  private

  def image_url
    params.require(:image).permit(:url)
  end
end
