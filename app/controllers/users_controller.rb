class UsersController < ApplicationController
    before_action :check_no_authenticate, only: [:new, :create]
    before_action :check_authenticate, only: [:edit, :update, :destroy]
    before_action :get_user, only: [:edit, :update, :destroy]

    def new
        session[:current_time] = Time.now
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.person?
            @user.build_person unless @user.person
        elsif @user.organization?
            @user.build_organization unless @user.organization
        end

        if @user.save
            sign_in(@user)
            flash[:success] = "Successful registration"
            redirect_to edit_user_path
        else
            flash[:error] = "Unable to save"
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @user = User.find(params[:id])
    end
    
    def edit
        @user.build_avatar unless @user.avatar.present?
        @user.build_person if @user.person? && !@user.person.present?
        @user.build_organization if @user.organization? && !@user.organization.present?
    end

    def update
        current_params = user_params_all

        # Сheck password only when specifying a new one
        if current_params[:password].blank? 
            # Check old password when changing login
            if current_params[:login] == @user.login
                current_params = current_params.except(:password, :password_confirmation, :old_password)
            else 
                current_params.except(:password_confirmation, :old_password)
            end
        end
        
        if current_params[:avatar_attributes][:image].blank? 
            current_params = current_params.except(:avatar_attributes)
        else
            @user.build_avatar if @user.avatar.present?
        end

        if @user.update(current_params)
            flash[:success] = "Data changed successfully"
            redirect_to show_user_path(@user)
        else
            flash[:error] = "Unable to update"
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy

    end

    private

    def user_params
        params.require(:user).permit(:login, :password, :password_confirmation, :account_type, :old_password)
    end

    def user_params_all
        params.require(:user).permit(
            :login, :password, :password_confirmation, :old_password,
            person_attributes: [:id, :name, :surname, :sex, :DOB, :about],
            organization_attributes: [:id, :name, :about],
            avatar_attributes: [:image]
        )
    end

    def get_user
        @user = User.find_by id: session[:user_id]
    end
end