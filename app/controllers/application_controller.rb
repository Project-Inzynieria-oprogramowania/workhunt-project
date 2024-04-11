class ApplicationController < ActionController::Base

    private

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
        if (@current_user)
            @current_user.build_person unless @current_user.person?
            @current_user.build_organization unless @current_user.organization?
        end
        @current_user 
    end

    def user_signed_in?
        current_user.present?
    end

    def check_authenticate
        return if user_signed_in?
        # flash[:warning] = "You are no signed in"
        redirect_to root_path
    end

    def check_no_authenticate
        return if !user_signed_in?
        # flash[:warning] = "You are already signed in"
        redirect_to root_path
    end

    def check_profile_organization
        return if user_signed_in? && current_user.organization?
        # flash[:warning] = "You may not change this information as an unauthorized or non-organizational user."
        redirect_to root_path
    end

    def sign_in( user )
        session[:user_id] = user.id
    end

    def sign_out
        session.delete :user_id
    end

    # Делает методы доступными не только в контроллерах, но и в представлениях
    helper_method :current_user, :user_signed_in? #, :sign_in
end