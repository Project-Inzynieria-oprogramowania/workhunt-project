class OrganizationsController < ApplicationController
    # def new
    #     session[:current_time] = Time.now
    #     @organization = Organization.new
    # end
    # def login
    # end

    # def create
    #     @organization = Organization.new organization_params
    #     if @organization.save
    #         session[:organization_id] = @organization.id
    #         flash[:success] = "Successful registration!"
    #         redirect_to root_path   # перенаправление на гравную страницу (мб на страницу пользователя?)
    #     else
    #         # flash[:error] = "Some errors in form"
    #         render :new, status: :unprocessable_entity
    #     end
    # end

    # private

    # def organization_params
    #     params.require(:organization).permit(:login, :password, :password_confirmation, :name, :about)
    # end
end