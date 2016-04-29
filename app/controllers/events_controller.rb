class EventsController < ApplicationController
  before_action :set_event, only:[:edit_event, :info_event]
  before_action :exist_user, only:[:index, :new_event, :event_info]

  def new_event
    @event = Event.new
  end

  def index
    @events = Event.where(user_id: current_user.id)
  end

  def edit_event
  end

  def update_event
  end

  def create_event
    @event = Event.new(event_params_for_new)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = "Ahora puedes empezar a subir tus fotografías en esta galería"
      redirect_to event_info_path(current_user.id, @event)
    else
      flash[:error] = @event.errors
      redirect_to event_new_path(current_user.id)
    end
  end

  def delete_event
    @event = Event.find_by(id: params[:event_id])
    @event.destroy
    redirect_to event_path(current_user.id)
  end

  def info_event
    @photos = Photo.where(event_id: params[:event_id])
  end

  private

  def event_params_for_new
    params.require(:event).permit(:event_name, :event_description)
  end

  def event_params_for_update
    params.require(:event).permit(:description)
  end

  def set_event
    @event = Event.find_by(user_id: current_user.id)
  end

end
