class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :all_destinations
  before_action :set_trip

  def all_destinations
    @destinations = Destination.all
  end

  def set_trip
    @trip = Trip.new(session[:trip])
  end

end
