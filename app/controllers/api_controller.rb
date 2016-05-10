class ApiController < ApplicationController
  before_filter :check_format
  before_action :set_user, only: [:auth_user, :info_user]
  respond_to :json


  def auth_user
    if @user.nil?
      respond_with nil, status: 400
    else
      respond_with true
    end
  end

  def create_user
    user = User.new(api_user_params)
    if user.save
      respond_with data:{message: "Bienvenido", status: 200}
    else
      respond_with data:{message: user.errors, status: 400}
    end
  end

  def info_user
    if @user.nil?
      respond_with nil, status: 400
    else
      respond_with data:{name: @user.complete_name, sex: @user.sex_humanize, email: @user.email, followers: @user.has_follow_users}
    end
  end

  def info_event
    event = Event.find_by(event_code: params[:id])
    if event.nil?
      respond_with nil, status: 400
    else
      gallery = Photo.where(event_id: event.id)
      photo_gallery = Array.new
      gallery.each do |photo|
        photo_gallery.push({id: photo.image_original_fingerprint,
                            original: photo.image_processed.url(:original),
                            medium: photo.image_processed.url(:medium),
                            small: photo.image_processed.url(:small),
                            thumb: photo.image_processed.url(:thumb)})
      end
      respond_with data:photo_gallery
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def api_user_params
    params.require(:user).permit(:email, :name, :lastname, :sex)
  end

end
