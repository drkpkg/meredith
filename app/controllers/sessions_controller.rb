class SessionsController < ApplicationController

    def login
        if !cookies[:idbmeredith].nil?
            current_user = cookies.signed[:idbmeredith]['$oid']
            redirect_to me_path(cookies.signed[:idbmeredith]['$oid'])
        else
            render layout: 'login'
        end
    end

    def authorize_user
        if params[:session][:email].blank? and params[:session][:password].blank?
            redirect_to login_path, notice: "Campos en blanco"
        else
            @user = User.find_by(email: params[:session][:email])
            begin
              if @user.password == params[:session][:password]
                session[:current_user_id] = @user.id
                if params[:session][:persistent_login]=='1'
                  cookies.permanent.signed[:idbmeredith] = @user.id
                else
                  cookies.signed[:idbmeredith] = @user.id
                end
                redirect_to me_path(@user)
              else
                redirect_to login_path, notice: "Por favor verifica tus datos"
              end
            rescue
              redirect_to login_path, notice: "Por favor verifica tus datos"
            end
        end
    end

    def logout
        @_current_user = session[:current_user_id] = nil
        cookies.delete :idbmeredith
        redirect_to root_url
    end

    private
    def verify_type
        if @user.user_type == 'client'
            redirect_to root_path
        end
    end

end
