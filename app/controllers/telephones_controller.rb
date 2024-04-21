class TelephonesController < ApplicationController
    before_action :check_authenticate
    before_action :set_user

    def create
        @telephone = @user.telephones.build(telephone_params)
        if @telephone.save
            flash[:success] = "Telephone added successfully."
            redirect_to user_settings_path
        else
            flash[:error] = "Failed to create telephone."
            render 'users/edit', status: :unprocessable_entity
        end
    end

    def destroy
        @telephone = @user.telephones.find(params[:id])
        @telephone.destroy
        flash[:success] = "Telephone deleted successfully."
        redirect_to user_settings_path
    end

    private

    def telephone_params
        params.require(:telephone).permit(:number)
    end

    def set_user
        @user = current_user
    end
end