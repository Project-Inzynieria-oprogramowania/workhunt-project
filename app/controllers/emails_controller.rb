class EmailsController < ApplicationController
    before_action :check_authenticate
    before_action :set_user

    def create
        @email = @user.emails.build(email_params)
        if @email.save
            flash[:success] = "Email #{params[:email][:address]} added successfully"
            redirect_to edit_user_path
        else
            flash[:error] = "Failed to create email."
            render 'users/edit', status: :unprocessable_entity
        end
    end

    def destroy
        @email = @user.emails.find(params[:id])
        @email.destroy
        flash[:success] = "Email deleted successfully"
        redirect_to edit_user_path
    end

    private

    def email_params
        params.require(:email).permit(:address)
    end

    def set_user
        @user ||= current_user
    end
end