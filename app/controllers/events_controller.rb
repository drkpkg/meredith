class EventsController < ApplicationController
   before_action :set_event, only:[:edit_event, :event_info]
   before_action :exist_user, only:[:index, :new_event, :event_info]
   
   def new_event
       @event = Event.new
   end
   
   def index
       @events = Event.where(user_id: params[:id])
   end
   
   def edit_event
   end
   
   def update_event
   end
   
   def create_event
       @event = Event.new(event_params_for_new)
       if @event.save
           redirect_to event_info_path(current_user.id, @event)
       else
           render 'new_event'
       end
   end
   
   def destroy_event
   end
   
   def info_event
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
