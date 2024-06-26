class CvsController < ApplicationController
    before_action :check_authenticate, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_profile_person, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_profile, only: [:edit, :update, :destroy]
    before_action :check_cv_not_exists, only: [:new, :create]
    before_action :check_cv_exists, only: [:edit, :update, :destroy]
    before_action :get_cv, only: [:edit, :update, :destroy]

    def new
        @cv ||= Cv.new
    end

    def create
        @cv = Cv.new cv_params_all
        @cv.person_id = current_user.person.id
        if @cv.save
            flash[:success] = "CV successfully created"
            redirect_to show_cv_path(@cv)
        else
            flash[:error] = "Unable to save"
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @cv = Cv.find(params[:id])
        
        respond_to do | format |
            format.html
            format.pdf do
                begin
                    pdf_content = CvsReport.new.to_pdf(@cv)
                    send_data pdf_content,
                        filename: "CV_#{Time.now.strftime("%Y%m%d-%H%M%S")}.pdf",
                        type: 'application/pdf',
                        disposition: 'inline'
                rescue => e
                    Rails.logger.error("Error in action 'show': #{e.message}")
                    render plain: "An error occurred while rendering the PDF", status: :internal_server_error
                end
            end
        end
    end

    def index
        searching(search_params)
    end

    def search
        searching(search_params)
        render partial: 'cvs/search_results', locals: { pagy: @pagy, cvs: @cvs }
    end

    def edit; end

    def update
        if @cv.update(cv_params_all)
            flash[:success] = "CV successfully updated"
            redirect_to show_cv_path(@cv)
        else
            flash[:error] = "Unable to update"
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @cv.destroy
        flash[:success] = "CV deleted successfully"
        redirect_to user_path(current_user)
    end

    private

    def cv_params_all
        params.require(:cv).permit(
            :about, :skills, :country, :city, :interests,
            educations_attributes: [:id, :start_date, :end_date, :institution, :direction, :specialization, :education_level],
            experiences_attributes: [:id, :start_date, :end_date, :position, :country, :city, :company, :outline, :responsibilities, :achievements],
            languages_attributes: [:id, :name, :level, :certificates]
        )
    end

    def search_params
        params.fetch(:q, {}).permit(
            :about_or_skills_cont, :educations_education_level_in
        )
    end

    def check_profile
        cv = Cv.find(current_user.person.cv.id)
        return if current_user.person.id == cv.person_id
        flash[:warning] = "You are not authorized to perform this action"
        redirect_back fallback_location: root_path
    end

    def check_cv_not_exists
        cv = current_user.person.cv
        return unless cv.present?
        flash[:warning] = "You already have a CV"
        redirect_to show_cv_path(cv)
    end

    def check_cv_exists
        return if current_user.person.cv.present?
        flash[:warning] = "You dont have a CV"
        redirect_to new_cv_path
    end

    def get_cv
        @cv ||= current_user.person.cv
    end

    def searching(search_params, action = 'index')
        @q = Cv.all.ransack(params[:q])
        current_url = url_for(controller: 'cvs', action: action, only_path: true)
        @pagy, @cvs = pagy(
            @q.result(distinct: true).includes(:educations),
            page_params: {q: search_params}.to_query,
            request_path: current_url,
        )
    end
end