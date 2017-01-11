class InquiriesController < ApplicationController

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    
    if @inquiry.save
      redirect_to root_path, notice: I18n.t("contact.success_alert")
    else
      render action: "new"
    end
  end

  private

  def inquiry_params
    params[:inquiry].permit(:name, :email, :phone, :message, :skype_id)
  end
end