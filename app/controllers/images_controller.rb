require 'open-uri'
require 'net/http'

class ImagesController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @images = Image.order('updated_at DESC')
  end

  def new
    @image = Image.new
  end

  def show
    @image = Image.find_by(id: params[:id])
    return @image unless @image.nil?
    flash[:error] = 'Image does not exist'
    redirect_to root_path
  end

  def create
    @image = Image.new(image_url)

    if @image.save
      flash[:notice] = 'Image successfully created'
      redirect_to action: 'show', id: @image.id
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def image_url
    params.require(:image).permit(:url)
  end
end
