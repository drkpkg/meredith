require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def check_format
    render :nothing => true, :status => 406 unless params[:format] == 'json' || request.headers["Accept"] =~ /json/
  end

  def current_user
    @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
  end

  def exist_user
    if session[:current_user_id].nil? and cookies.signed[:idbmeredith].nil?
      redirect_to root_path
    else
      session[:current_user_id] = cookies.signed[:idbmeredith]['$oid']
    end
  end

  def verify_user
    begin
      user = User.find_by(id: cookies.signed[:idbmeredith]['$oid'])
      if user.nil?
        session[:current_user_id] = nil
        cookies.delete(:idbmeredith)
      else
        if session[:current_user_id].nil? and !cookies.signed[:idbmeredith].nil?
          session[:current_user_id] = cookies.signed[:idbmeredith]['$oid']
        else
          session[:current_user_id] = nil
        end
      end
    rescue
      cookies.delete(:idbmeredith)
      session[:current_user_id] = nil
    end
  end

  def has_permissions
    user = User.find_by(id: cookies.signed[:idbmeredith]['$oid'])
    if user.user_type != 'photographer'
      redirect_to me_path(user.id)
    end
  end
end
