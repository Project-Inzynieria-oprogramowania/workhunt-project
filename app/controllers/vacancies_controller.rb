class VacanciesController < ApplicationController
    before_action :check_profile_organization, only: [:new, :create]

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
        
        # @vacancy = Vacancy.new(vacancy_params.merge(salary_min_cents: salary_min_cents, salary_max_cents: salary_max_cents))
        if @vacancy.save
            # flash[:success] = "Job vacancy successfully created"
            redirect_to vacancies_path
        else
            # flash[:warning] = "Cannot be save. Some errors in form"
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @vacancy = Vacancy.find_by id: params[:id]
    end

    def index
        @vacancies = Vacancy.all
    end

    private 

    def vacancy_params
        params.require(:vacancy).permit(
            :title, :description, :salary_min, :salary_max, :currency, 
            :country, :city, 
            :skills_mandatory, :skills_optional, 
            :experience, :job_type, :job_category, :education, 
            :subordination_level, :contract_type, :working_time, 
            :work_type, :status)
    end
end