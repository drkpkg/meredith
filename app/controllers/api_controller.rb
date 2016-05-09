class ApiController < ApplicationController

  before_action :set_user, only: [:_auth_user, :_info_user]

  def auth_user

  end

  def create_user

  end

  def info_user
    respond_to do |format|
      if user.nil?
        format.html {render text: "Hey, staph", status: 400}
        format.json {render json: {data: ["Hey, staph", status: 400]}}
      else
        format.html {render json: user.to_json}
        format.json {render user.to_json}
      end
    end
  end

  def info_event
    event = Event.find_by(event_code: params[:id])
    respond_to do |format|
      if event.nil?
        format.html {render text: "Hey, staph", status: 400}
        format.json {render json: {data: ["Hey, staph", status: 400]}}
      else
        photo_gallery = Array.new
        Photo.where(event_id: event.id).each do |photo|
          photo_gallery.push({id: photo.image_original_fingerprint,
                              original: photo.image_processed.url(:original),
                              medium: photo.image_processed.url(:medium),
                              small: photo.image_processed.url(:small),
                              thumb: photo.image_processed.url(:thumb)})
        end
        format.html {render json: photo_gallery.as_json }
        format.json {render photo_gallery.as_json}
      end
    end
  end



  private

  def set_user
    user = User.find_by(id: params[:id])
  end

end
