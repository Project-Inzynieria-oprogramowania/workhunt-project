class HomeController < ApplicationController
  def index
  end

  def routing_error
    not_found(ActionController::RoutingError)
  end
end