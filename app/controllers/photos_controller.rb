require 'base64'

class PhotosController < ApplicationController

  before_action :verify_user
  before_action :set_photo_gallery, only: [:index, :create, :delete, :get_photo]
  before_action :has_permissions, except: [:photographer_gallery, :like_photo, :authorize_sell, :photographer_photo_gallery, :get_photo_processed]

  def index
  end

  def create
    params[:photo][:image].each do |new_photo|
      @photo = Photo.new
      @photo.event_id = params[:event_id]
      @photo.image_original = Base64.encode64(open(new_photo.path).to_a.join)
      @photo.image_processed = new_photo
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

  def get_photo
    @photo_actual = Photo.find_by(id: params[:id])
  end

  def photographer_gallery
    @user = User.find_by(id: cookies.signed[:idbmeredith]['$oid'])
    @events = Event.where(user_id: params[:photographer_id])
  end

  def photographer_photo_gallery
    @user = User.find_by(id: cookies.signed[:idbmeredith]['$oid'])
    @photos = Photo.where(event_id: params[:event_id])
  end

  def unlike_photo
    @photos = Photo.where(event_id: params[:event_id])
    @actual_photo = Photo.find_by(id: params[:photo_id])
    @actual_photo.likes.delete(cookies.signed[:idbmeredith]['$oid'])
    @actual_photos.likes = @actual_photo.likes.uniq
    @actual_photos.save
  end

  def like_photo
    @photos = Photo.where(event_id: params[:event_id])
    @actual_photo = Photo.find_by(id: params[:photo_id])
    @actual_photo.likes.push(cookies.signed[:idbmeredith]['$oid'])
    @actual_photo.likes = @actual_photo.likes.uniq
    @actual_photo.save
  end

  def get_photo_processed
    @photo_actual = Photo.find_by(id: params[:id])
  end

  def authorize_sell

  end

  private

  def set_photo_gallery
    @photos = Photo.where(event_id: params[:event_id])
  end
end
