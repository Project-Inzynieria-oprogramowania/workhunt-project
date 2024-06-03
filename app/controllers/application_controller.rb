class ApplicationController < ActionController::Base
    include Pagy::Backend
    include Authentication
    include ErrorHandling
    
    private
    
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
end