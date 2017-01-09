class Admins::DashboardController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  
  def home

  end

end