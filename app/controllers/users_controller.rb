class UsersController < ApplicationController
    before_action :check_no_authenticate, only: [:new, :create]
    before_action :check_authenticate, only: [:edit, :update]

    def new
        session[:current_time] = Time.now
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            sign_in(@user)
            # flash[:success] = "Successful registration"
            redirect_to root_path   # перенаправление на главную страницу (мб на страницу пользователя?)
        else
            # flash.now[:error] = "Some errors in form"
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit
        @user ||= User.find_by id: session[:user_id]
        @user.build_person unless @user.person?
        @user.build_organization unless @user.organization?
    end

    def update
        @user = User.find_by id: session[:user_id]
        
        current_params = user_params_all

        # Сheck password only when specifying a new one
        if current_params[:password].blank? 
            # Check old password when changing login
            if current_params[:login] == @user.login
                current_params = current_params.except(:password, :password_confirmation, :old_password)
            else 
                current_params.except(:password_confirmation, :old_password)
            end
        end

        if @user.update(current_params)
            # flash[:success] = "Data changed successfully"
            redirect_to user_settings_path
        else
            # flash[:warning] = "Some errors in form"
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:login, :password, :password_confirmation, :account_type, :old_password)
    end

    def user_params_all
        params.require(:user).permit(
            :login, :password, :password_confirmation, :old_password,
            person_attributes: [:id, :name, :surname, :sex, :DOB, :about],
            organization_attributes: [:id, :name, :about]
        )
    end
end