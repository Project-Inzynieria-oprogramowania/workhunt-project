class VacanciesController < ApplicationController
    before_action :check_profile_organization, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_organization, only: [:edit, :update, :destroy]
    before_action :get_vacancy, only: [:show, :edit, :update, :destroy]
    
    def new
        @vacancy ||= Vacancy.new
    end

    def create
        @vacancy = Vacancy.new(vacancy_params)
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
        puts "===============\n#{params[:q].inspect}\n=========================="
        @vacancies = Vacancy.where(status: 'Opened')
        if params[:q].present? && params[:q][:salary_min_cents_gteq].present?
            min_salary = params[:q][:salary_min_cents_gteq].to_i * 100
            @vacancies = @vacancies.where(
                'salary_min_cents >= ? OR (salary_min_cents IS NULL AND (salary_max_cents >= ? OR salary_max_cents IS NULL))',
                min_salary, min_salary
            )
        end
        @q = @vacancies.ransack(params[:q])
        @vacancies = @q.result(distinct: true)
    end

    def edit
    end

    def update
        @vacancy.organization_id = current_user.organization.id
        
        if @vacancy.update(vacancy_params)
            flash[:success] = "Job vacancy successfully updated"
            redirect_to vacancy_path(@vacancy)
        else
            flash[:error] = "Cannot be save. Some errors in form"
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

    
        # params.require(:search).permit(
        #     :title_or_description_cont,
        #     :job_type_in, :work_type_in, :education_in, :subordination_level_in, :contract_type_in, :working_time_in,
        #     :salary_min_cents_gteq
        # )
    # def search_vacancy_params
    #     if params[:q].present?
    #         params.require(:q).permit(
    #             :title_or_description_cont, 
    #             :job_type_in, :work_type_in, :education_in, :subordination_level_in, :contract_type_in, :working_time_in, :currency_in,
    #             :salary_min_cents_gteq
    #         )
    #     else
    #         {}
    #     end
    # end

    def check_organization
        @vacancy = Vacancy.find(params[:id])
        unless current_user.organization.id == @vacancy.organization_id
            flash[:warning] = "You are not authorized to perform this action."
            redirect_back fallback_location: root_path
        end
    end

    def get_vacancy
        @vacancy = Vacancy.find(params[:id])
    end
end