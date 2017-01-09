class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  include ApplicationHelper
     
  protect_from_forgery with: :exception

  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    if resource.class == Admin
      admins_home_path
    else 
      user_home_path
    end
  end

  def after_sign_out_path_for(resource)
   if resource == :user
      users_sign_in_path
    else 
      admins_sign_in_path 
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
    end
  end

  rescue_from ActionController::RoutingError, with: :not_found

  def raise_not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def not_found
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
    end
  end

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    else
      "application"
    end
  end
end