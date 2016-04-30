class UsersController < ApplicationController
  before_action :exist_user, only: [:dashboard, :profile, :edit_profile]
  before_action :verify_user, only: [:new_profile]
  before_action :set_user, only: [:edit_profile, :profile, :dashboard, :update_profile, :destroy_profile]
  layout 'welcome', only: [:new_profile]
  
  def dashboard
  end

  def profile
  end

  def new_profile
    if session[:current_user_id]
      redirect_to me_path(session[:current_user_id])
    else
      @user = User.new
      render layout: 'signup'
    end

  end

  def edit_profile
  end

  def create_profile
    @user = User.new(user_params_for_new)
    @user.save
    respond_to do |format|
        format.html
        format.js
    end
  end

  def update_profile
    set_params(params)
    if @user.update(user_params_for_update)
      redirect_to me_path(@user), notice: "Actualizaste tu perfil, yay"
    else
      flash[:error] = @user.errors
      redirect_to me_edit_path(@user)
    end
  end

  def destroy_profile
    @user.destroy
    redirect_to signup_path, notice: "Te vamos a extrañar, muack"
  end

  def block_profile
  end

  def follow_profile
  end

  def suscribe_event
  end
  
  private 
  
  def user_params_for_new
    params.require(:user).permit(:email, :terms, :password, :password_confirmation, :user_type)
  end
  
  def user_params_for_update
    params.require(:user).permit(:name, :lastname, :alias, :avatar, :phones_list, :social_networks_list, :sex, :address)
  end
  
  def set_user
    @user = User.find_by(id: current_user.id)
  end

  def set_params(params)
    @user.phones_list = params[:user][:phones_list]
    @user.social_networks_list = params[:user][:social_networks_list]
    @user.profile_is_complete
  end
end
