class ApplicationController < ActionController::Base

    private

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def user_signed_in?
        current_user.present?
    end

    def current_organization
        @current_organization ||= Organization.find_by(id: session[:organization_id]) if session[:organization_id].present?
    end

    def organization_signed_in?
        current_organization.present?
    end

    # Делает методы доступными не только в контроллерах, но и в представлениях
    helper_method :current_user, :user_signed_in?, :current_organization, :organization_signed_in?
end