class VacancyResponsesController < ApplicationController
    before_action :check_authenticate
    before_action :check_profile_organization, only: [:update]
    before_action :check_profile_person, only: [:create]
    before_action :check_authenticate_access, only: [:index]

    def index
        if params[:vacancy_id]
            @responses = VacancyResponses.find_by(vacancy_id: params[:vacancy_id])
        else
            @responses = VacancyResponses.find_by(user_id: user.person.id)
        end
    end

    def create

    end

    def show

    end

    def update

    end

    def destroy

    end

    private

    def check_authenticate_access
        if current_user.person?
            return if current_user.person.id == VacancyResponse.find(params[:id]).person_id
            # flash[:warning]
            # redirect_to
        end
        if current_user.organization?
            return if current_user.organization.id == Vacancy.find(VacancyResponse.find(params[:id]).vacancy_id).organization_id
            # flash[:warning]
            # redirect_to
        end

        # if params[:vacancy_id]
        #     return if current_user.organization? && current_user.organization.id == Vacancy.find(vacancy_id).organization_id
        #     flash[:warning] = ""
        #     redirect_to root_path
        # else
        #     return if current_user.person?
        #     flash[:warning] = "This option is not available"
        #     redirect_to show_user_path(current_user)
        # end
    end
end