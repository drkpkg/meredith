class PhotosController < ApplicationController

  before_action :set_photo_gallery, only: [:index, :create, :delete]

  def index
  end

  def create
    params[:photo][:image].each do |new_photo|
      @photo = Photo.new
      @photo.event_id = params[:event_id]
      @photo.image = new_photo
      @photo.save
    end
    @user_id = params[:id]
    @event_id = params[:event_id]
  end

  def delete
    @user_id = params[:id]
    @event_id = params[:event_id]

    photo = Photo.find_by(id: params[:image_id])
    photo.destroy
  end

  private

  def set_photo_gallery
    @photos = Photo.where(event_id: params[:event_id])
  end
end
