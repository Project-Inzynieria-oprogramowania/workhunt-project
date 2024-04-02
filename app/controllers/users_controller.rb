class UsersController < ApplicationController
    def registration
        @user = User.new
    end
    def login
    end

    # def index
    # end
    # def show
    #     #@user = User.find(params[:id])
    # end
end