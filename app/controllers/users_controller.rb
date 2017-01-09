class UsersController < ApplicationController
  load_and_authorize_resource :except=> [:dashboard,:page]
  before_filter :authenticate_user!,except: [:dashboard,:page]

  def dashboard
  end
 
  def home
  end

  def show
  	@user = User.friendly.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      flash[:success] = I18n.t('general.password_updated_successfully')
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end
  
  def page
    @static_page = StaticPage.find_by(page_route: params[:route])
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
