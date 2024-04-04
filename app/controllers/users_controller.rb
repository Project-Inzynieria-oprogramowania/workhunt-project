class UsersController < ApplicationController
    def registration
        @user = User.new
    end
    def login
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Successful registration!"
            redirect_to root_path   # перенаправление на гравную страницу (мб на страницу пользователя?)
        else
            render :registration
        end
    end
    # def index
    # end
    # def show
    #     #@user = User.find(params[:id])
    # end

    private

    def user_params
        params.require(:user).permit(:login, :password, :password_confirmation, :name, :surname, :about)
    end
end