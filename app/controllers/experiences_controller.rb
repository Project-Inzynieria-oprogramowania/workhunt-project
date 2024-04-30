class ExperiencesController < ApplicationController
    before_action :set_cv_for_current, only: [:new]
    
    def new
        @experience = @cv.experiences.build
        render partial: 'experiences/form', locals: {index: params[:index].to_i, experience: @experience}
    end

    def destroy
        @experience = Experience.find_by(id: params[:id]) if params[:id].present?
        @experience.destroy if @experience.present?
    end
end