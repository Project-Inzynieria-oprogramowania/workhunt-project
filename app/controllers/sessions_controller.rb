class SessionsController < ApplicationController
    def new
        @user ||= User.new
    end

    def create
        @user = User.find_by login: params[:user][:login]
        if (@user&.authenticate(params[:user][:password]))
            sign_in(@user)
            redirect_to root_path
        else
            @user = User.new(login: params[:user][:login])
            @user.errors.add(:password, "Invalid login or password")
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        sign_out
        redirect_to root_path
    end
end