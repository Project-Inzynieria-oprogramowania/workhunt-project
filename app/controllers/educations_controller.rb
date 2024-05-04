class EducationsController < ApplicationController
    before_action :set_cv_for_current, only: [:new]
    
    def new
        @education = @cv.educations.build
        render partial: 'educations/form', locals: {index: params[:index].to_i, education: @education}
    end

    def destroy
        @education = Education.find_by(id: params[:id]) if params[:id].present?
        @education.destroy if @education.present?
    end
end