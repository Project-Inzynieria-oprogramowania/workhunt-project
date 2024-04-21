class LinksController < ApplicationController
    before_action :set_user

    def create
        @link = @user.links.build(link_params)
        if @link.save
            flash[:success] = "Link added successfully."
            redirect_to user_settings_path
        else
            flash[:error] = "Failed to create link."
            render 'users/edit', status: :unprocessable_entity
        end
    end

    def destroy
        @link = @user.links.find(params[:id])
        @link.destroy
        flash[:success] = "Link deleted successfully."
        redirect_to user_settings_path
    end

    private

    def link_params
        params.require(:link).permit(:address)
    end

    def set_user
        @user = current_user
    end
end