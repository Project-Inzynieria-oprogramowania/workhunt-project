class UsersController < ApplicationController
    before_action :check_no_authenticate, only: [:new, :create]

    def new
        session[:current_time] = Time.now
        @user = User.new
    end

    def create
        puts "==============\n#{params.inspect}\n==============="
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
    # def index
    # end
    # def show
    #     #@user = User.find(params[:id])
    # end

    private

    def user_params
        params.require(:user).permit(:login, :password, :password_confirmation, :account_type)
    end
end