class LinksController < ApplicationController
    before_action :check_authenticate
    before_action :set_user

    def create
        @link = @user.links.build(link_params)
        if @link.save
            flash[:success] = "Link added successfully"
            redirect_to edit_user_path
        else
            flash[:error] = "Failed to create link"
            render 'users/edit', status: :unprocessable_entity
        end
    end

    def destroy
        @link = @user.links.find(params[:id])
        @link.destroy
        flash[:success] = "Link deleted successfully"
        redirect_to edit_user_path
    end

    private

    def link_params
        params.require(:link).permit(:address, :title)
    end

    def set_user
        @user ||= current_user
    end
end