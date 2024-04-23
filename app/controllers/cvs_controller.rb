class CvsController < ApplicationController
    before_action :check_authenticate, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_profile_person, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_profile, only: [:edit, :update, :destroy]
    before_action :check_cv_exists, only: [:new, :create]
    before_action :get_cv, only: [:edit, :update, :destroy]
    before_action :set_cv, only: [:add_education, :add_experience, :add_language]

    def new
        @cv ||= Cv.new
    end

    def create
        @cv = Cv.new cv_params_all
        @cv.person_id = current_user.person.id
        if @cv.save
            flash[:success] = "CV successfully created"
            redirect_to show_cvs_path(@cv)
        else
            flash[:error] = "Unable to save"
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @cv = Cv.find(params[:id])
    end

    def index
    end

    def edit
    end

    def update
        if @cv.update(cv_params_all)
            flash[:success] = "CV successfully updated"
            redirect_to show_cvs_path(@cv)
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

    def add_education
        @education = @cv.educations.build
        render partial: 'educations/form', locals: {index: params[:index].to_i, education: @education}
    end

    def remove_education
        @education = Education.find_by(id: params[:id]) if params[:id].present?
        @education.destroy if @education.present?
    end

    def add_experience
        @experience = @cv.experiences.build
        render partial: 'experiences/form', locals: {index: params[:index].to_i, experience: @experience}
    end

    def remove_experience
        @experience = Experience.find_by(id: params[:id]) if params[:id].present?
        @experience.destroy if @experience.present?
    end

    def add_language
        @language = @cv.languages.build
        render partial: 'languages/form', locals: {index: params[:index].to_i, language: @language}
    end

    def remove_language
        @language = Language.find_by(id: params[:id]) if params[:id].present?
        @language.destroy if @language.present?
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

    def check_profile
        cv = Cv.find(current_user.person.cv.id)
        return if current_user.person.id == cv.person_id
        flash[:warning] = "You are not authorized to perform this action"
        redirect_back fallback_location: root_path
    end

    def check_cv_exists
        cv = current_user.person.cv
        return unless current_user.person.cv.present?
        flash[:warning] = "You already have a CV"
        redirect_to cv_path(cv)
    end

    def get_cv
        @cv ||= current_user.person.cv
    end

    def set_cv
        @cv = current_user.person.cv || Cv.new
    end
end