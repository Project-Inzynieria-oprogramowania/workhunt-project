class ResponsesController < ApplicationController
    before_action :check_authenticate
    before_action :get_response, only: [:show, :update, :destroy]
    before_action :check_authenticate_access, only: [:show]
    before_action :check_authenticate_access_all, only: [:index]
    before_action :check_profile_organization, only: [:update]
    before_action :check_organization, only: [:update]
    before_action :check_profile_person, only: [:create]
    before_action :check_person, only: [:destroy]

    def index
        if current_user.person?
            @responses = current_user.person.vacancy_responses
        else 
            @responses = VacancyResponse.where(vacancy_id: params[:vacancy_id])
        end
    end

    def create
        @response = VacancyResponse.new
        @response.person_id = Person.find_by(user_id: current_user.id).id
        @response.vacancy_id = params[:vacancy_id]
        @response.sent!
        if @response.save
            flash[:success] = "You have successfully applied for a vacancy"
            if !current_user.person.cv.present?
                flash[:warning] = "Create a CV to have your application considered"
            end
            redirect_to response_path(@response)
        else
            flash[:error] = "You are already response this vacancy"
            # redirect_to vacancy_path(params[:vacancy_id])#, status: :unprocessable_entity
            render 'vacancies/show', status: :unprocessable_entity
        end
    end

    def show
    end

    def update
        puts "\n===============\n#{params.inspect}\n==============\n"
        if @response.update({
            comments: params[:vacancy_response][:comments],
            status: params[:vacancy_response][:status]}
        )
            flash[:success] = "Response successfully updated"
            redirect_to response_path(@response)
        else
            flash[:error] = "Unable to update"
            render :show, status: :unprocessable_entity
        end
    end

    def destroy
        @response.destroy
        flash[:success] = "Response deleted successfully"
        redirect_to user_responses_path
    end

    private

    def get_response
        @response = VacancyResponse.find(params[:id])
    end

    def check_organization
        return if current_user.organization == @response.vacancy.organization
        flash[:error] = "You do not have access to this page"
        redirect_to root_path
    end

    def check_person
        return if current_user.person == @response.person
        flash[:error] = "You do not have access to this page"
        redirect_to root_path
    end

    def check_authenticate_access
        if current_user.person?
            check_person
        else 
            check_organization
        end
    end

    def check_authenticate_access_all
        if current_user.organization? 
            if params[:vacancy_id].present?
                return if current_user.organization == Vacancy.find(params[:vacancy_id]).organization
                flash[:error] = "You do not have access to this page"
                redirect_to root_path
            else 
                flash[:error] = "You do not have access to this page"
                redirect_to root_path
            end
        else
            return if !params[:vacancy_id].present?
            flash[:error] = "You do not have access to this page"
            redirect_to root_path
        end
    end
end