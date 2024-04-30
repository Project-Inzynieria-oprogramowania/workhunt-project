class LanguagesController < ApplicationController
    before_action :set_cv_for_current, only: [:new]
    
    def new
        @language = @cv.languages.build
        render partial: 'languages/form', locals: {index: params[:index].to_i, language: @language}
    end

    def destroy
        @language = Language.find_by(id: params[:id]) if params[:id].present?
        @language.destroy if @language.present?
    end
end