require 'open-uri'
require 'net/http'

class ImagesController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @images = if params[:tag].blank?
                Image.order('created_at DESC')
              else
                Image.order('created_at DESC').tagged_with(params[:tag])
              end
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

  def edit
    @image = Image.find(params[:id])
    return @image unless @image.nil?
    flash[:error] = 'Image does not exist'
    redirect_to root_path
  end

  def update
    @image = Image.find(params[:id])
    if @image.update(image_url)
      redirect_to action: 'show', id: @image.id
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    # Assuming the user won't abuse delete
    # otherwise exceptions should be thrown
    @image = Image.find_by(id: params[:id])
    if @image.nil?
      flash[:error] = 'Delete Failed!'
    else
      @image.destroy
      flash[:notice] = 'Image Deleted!'
    end
    redirect_to images_path
  end

  private

  def image_url
    params.require(:image).permit(:url, :tag_list)
  end
end
