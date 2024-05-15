class ApplicationController < ActionController::Base
    include ErrorHandling
    
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
        return if current_user.present?
        flash[:warning] = "You are no signed in"
        redirect_to new_session_path
    end

    def check_no_authenticate
        return if !current_user.present?
        flash[:warning] = "You are already signed in"
        redirect_back fallback_location: root_path
    end

    def check_profile_organization
        return if current_user.present? && current_user.organization?
        flash[:warning] = "You do not have access to this page non-organizational user"
        redirect_back fallback_location: root_path
    end

    def check_profile_person
        return if current_user.present? && current_user.person?
        flash[:warning] = "You do not have access to this page non-personal user"
        redirect_back fallback_location: root_path
    end

    def set_cv_for_current
        @cv = current_user.person.cv || Cv.new
    end
    
    def sign_in( user )
        session[:user_id] = user.id
    end

    def sign_out
        session.delete :user_id
    end    

    # Делает методы доступными не только в контроллерах, но и в представлениях
    helper_method :current_user, :user_signed_in?
end