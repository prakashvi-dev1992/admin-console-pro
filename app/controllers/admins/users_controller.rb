class Admins::UsersController < ApplicationController

	layout 'admin'

	before_action :authenticate_admin!

	helper_method :sort_column, :sort_direction

  def index
		if request.xhr? == 0 and !params.has_key?('direction')
			@users = User.filter(:first_name,params[:first_name]).filter(:last_name,params[:last_name]).filter(:city,params[:city]).order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 5)
		elsif request.xhr? ==0  and params.has_key?('direction')
			@users = User.all.order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 5)
		else
			@users = User.all.order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 5)
		end
  end

  def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.add_role params[:role]
		if @user.save
			redirect_to admins_users_path, notice: I18n.t("general.create_a_user")
		else
			render action: "new"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.add_role params[:role]
		if @user.update_attributes(edit_user_params)
			redirect_to admins_users_path, notice: I18n.t("general.update_a_user")
		else
			render action: "edit"
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to admins_users_path, notice: I18n.t("general.destroy_a_user")
	end

	private

	def user_params
		params[:user].permit(:first_name, :last_name, :city, :email, :mobile_number, :password, :password_confirmation)
	end

	def edit_user_params
		params[:user].permit(:first_name, :last_name, :city, :email, :mobile_number)
	end

	def sort_column
    User.column_names.include?(params[:column]) ? params[:column] : (params[:column] ? params[:column] : "first_name")
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
