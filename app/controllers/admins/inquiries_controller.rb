class Admins::InquiriesController < ApplicationController

  layout 'admin'

  before_action :authenticate_admin!

  helper_method :sort_column, :sort_direction

  def index
    @inquiries = Inquiry.filter(:name,params[:name]).filter(:email,params[:email]).filter(:skype_id,params[:skype_id]).order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 5)
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      redirect_to admins_inquiries_path, notice: I18n.t("general.create_a_inquiry")
    else
      render action: "new"
    end
  end

  def edit
    @inquiry = Inquiry.find(params[:id])
  end

  def update
    @inquiry = Inquiry.find(params[:id])
    if @inquiry.update_attributes(inquiry_params)
      redirect_to admins_inquiries_path, notice: I18n.t("general.update_a_inquiry")
    else
      render action: "edit"
    end
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    redirect_to admins_inquiries_path, notice: I18n.t("general.destroy_a_inquiry")
  end

  private

  def inquiry_params
    params[:inquiry].permit(:name,:email, :phone, :message, :skype_id)
  end

  def sort_column
    Inquiry.column_names.include?(params[:column]) ? params[:column] : (params[:column] ? params[:column] : "name")
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end