class VacanciesController < ApplicationController
    before_action :check_profile_organization, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_organization, only: [:edit, :update, :destroy]
    before_action :get_vacancy, only: [:show, :edit, :update, :destroy]

    def new
        @vacancy ||= Vacancy.new
    end

    def create
        salary_min = Money.from_amount(params[:vacancy][:salary_min].to_f, params[:vacancy][:currency])
        salary_max = Money.from_amount(params[:vacancy][:salary_max].to_f, params[:vacancy][:currency])
        @vacancy = Vacancy.new(vacancy_params)
        @vacancy.salary_min_cents = salary_min.cents
        @vacancy.salary_max_cents = salary_max.cents
        @vacancy.organization_id = current_user.organization.id
        
        if @vacancy.save
            flash[:success] = "Job vacancy successfully created"
            redirect_to vacancies_path
        else
            flash[:error] = "Cannot be save. Some errors in form"
            render :new, status: :unprocessable_entity
        end
    end

    def show
    end

    def index
        @q = Vacancy.where(status: 'Opened').ransack(params[:q])
        @vacancies = @q.result(distinct: true)
    end

    def edit
    end

    def update
        salary_min = Money.from_amount(params[:vacancy][:salary_min].to_f, params[:vacancy][:currency])
        salary_max = Money.from_amount(params[:vacancy][:salary_max].to_f, params[:vacancy][:currency])
        @vacancy.salary_min_cents = salary_min.cents
        @vacancy.salary_max_cents = salary_max.cents
        @vacancy.organization_id = current_user.organization.id
        
        if @vacancy.update(vacancy_params)
            flash[:success] = "Job vacancy successfully created"
            redirect_to vacancy_path(@vacancy)
        else
            flash[:warning] = "Cannot be save. Some errors in form"
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @vacancy.destroy
        redirect_to vacancies_path
    end

    private 

    def vacancy_params
        params.require(:vacancy).permit(
            :title, :description, :salary_min, :salary_max, :currency, 
            :country, :city, 
            :skills_mandatory, :skills_optional, 
            :experience, :job_type, :job_category, :education, 
            :subordination_level, :contract_type, :working_time, 
            :work_type, :status, :organization_id)
    end

    def check_organization
        @vacancy = Vacancy.find_by id: params[:id]
        unless current_user.organization.id == @vacancy.organization_id
            flash[:warning] = "You are not authorized to perform this action."
            redirect_back fallback_location: root_path
        end
    end

    def get_vacancy
        @vacancy = Vacancy.find_by id: params[:id]
    end
end