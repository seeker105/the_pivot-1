class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: "/public/404" unless current_admin?
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def show
  end

  def destroy
    
  end


end
