class VacanciesController < ApplicationController
    before_action :check_profile_organization, only: [:new, :create]


    def new 

    end

    def create

    end

    private 

    def vacancy_params

    end
end