class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
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
    if session[:current_user_id].nil? and !cookies.signed[:idbmeredith].nil?
      session[:current_user_id] = cookies.signed[:idbmeredith]['$oid']
    else
      session[:current_user_id] = nil
    end
  end
end
