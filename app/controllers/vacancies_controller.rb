class VacanciesController < ApplicationController
    before_action :check_profile_organization, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_profile, only: [:edit, :update, :destroy]
    before_action :get_vacancy, only: [:show, :edit, :update, :destroy]
    
    def new
        @vacancy ||= Vacancy.new
    end

    def create
        @vacancy = Vacancy.new(vacancy_params)
        @vacancy.organization_id = current_user.organization.id
        
        if @vacancy.save
            flash[:success] = "Job vacancy successfully created"
            redirect_to vacancy_path(@vacancy)
        else
            flash[:error] = "Unable to save"
            render :new, status: :unprocessable_entity
        end
    end

    def show
    end

    def index
        searching(search_params)
    end

    def search
        searching(search_params)
        render partial: 'vacancies/search_results', locals: { pagy: @pagy, vacancies: @vacancies }
    end

    def edit; end

    def update
        @vacancy.organization_id = current_user.organization.id
        
        if @vacancy.update(vacancy_params)
            flash[:success] = "Job vacancy successfully updated"
            redirect_to vacancy_path(@vacancy)
        else
            flash[:error] = "Unable to update"
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @vacancy.destroy
        flash[:success] = "Vacancy deleted successfully"
        redirect_to show_user_path(current_user)
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

    def search_params
        params.fetch(:q, {}).permit(
            :title_or_description_cont, 
            :job_type_in, :work_type_in, :education_in, :subordination_level_in, :contract_type_in, :working_time_in, 
            :salary_min_cents_gteq, :currency_in)
    end

    def check_profile
        @vacancy = Vacancy.find(params[:id])
        return if current_user.organization.id == @vacancy.organization_id
        flash[:warning] = "You are not authorized to perform this action"
        redirect_back fallback_location: root_path
    end

    def get_vacancy
        @vacancy ||= Vacancy.find(params[:id])
    end

    def searching(search_params, action = 'index')
        @vacancies = Vacancy.where(status: 'Opened')
        if search_params.present? && search_params[:salary_min_cents_gteq].present?
            min_salary = search_params[:salary_min_cents_gteq].to_i * 100
            @vacancies = @vacancies.where(
                'salary_min_cents >= ? OR (salary_min_cents IS NULL AND (salary_max_cents >= ? OR salary_max_cents IS NULL))',
                min_salary, min_salary
            )
        end
        @q = @vacancies.ransack(search_params)        
        current_url = url_for(controller: 'vacancies', action: action, only_path: true)
        @pagy, @vacancies = pagy(
            @q.result(distinct: true),
            page_params: {q: search_params}.to_query,
            request_path: current_url,
        )
    end
end