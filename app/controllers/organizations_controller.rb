class OrganizationsController < ApplicationController
    def registration
        @user = User.new
    end
    def login
    end
end