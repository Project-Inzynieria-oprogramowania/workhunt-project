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
            # flash[:success] = "Successful registration!"
            redirect_to root_path   # перенаправление на главную страницу (мб на страницу пользователя?)
        else
            # flash.now[:error] = "Some errors in form"
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit
        # puts "=============3\n#{@user.inspect}\n=============="
        @user ||= User.find_by id: session[:user_id]
    end

    def update
        @user = User.find_by id: session[:user_id]
        current_params = user_params

        # Сheck password only when specifying a new one
        if user_params[:password].blank?
            current_params = user_params.except(:password, :password_confirmation, :old_password)
        end

        if @user.update(current_params)
            # case @user.account_type
            # when 'person'
            #     @person = @user.account || @user.build_account(type: 'Person')
            #     @person.update(person_params)
            # when 'organization'
            #     @organization = @user.account || @user.build_account(type: 'Organization')
            #     @organization.update(organization_params)
            # end
            # flash[:success] = "User profile updated successfully"
            redirect_to user_settings_path
        else
            # @user = User.new user_params
            # @user.build_person if @user.person?.nil?
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:login, :password, :password_confirmation, :account_type, :old_password)
    end

    # def user_params_all
    #     params.require(:user).permit(:id, :login, :password, :password_confirmation, :old_password, person_attributes: [:name, :surname, :sex, :DOB, :about])
    # end

    # def person_params
    #     params.require(:person).permit(:name, :surname, :sex, :DOB, :about)
    # end

    # def organization_params
    #     params.require(:organization).permit(:name, :about)
    # end
end