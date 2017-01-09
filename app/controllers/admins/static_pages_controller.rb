class Admins::StaticPagesController < ApplicationController
  
  layout 'admin'

  before_action :authenticate_admin!

  helper_method :sort_column, :sort_direction

	def new
		@static_page = StaticPage.new
	end

	def create
		@static_page = StaticPage.create(static_page_params)
    if @static_page.save
      redirect_to admins_static_pages_path, notice: I18n.t("general.create_a_page")
    else
      render action: "new"
    end
	end
		
	def index
    @static_pages = StaticPage.filter(:name,params[:name]).filter(:label,params[:label]).filter(:page_route,params[:page_route]).order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 5)
  end

  def show
  	@static_page = StaticPage.find_by_id(params[:id])
  end

  def page
    @static_page = StaticPage.find_by(page_route: params[:route])
  end

  def edit
  	@static_page = StaticPage.find_by_id(params[:id])
  end

  def update
  	@static_page = StaticPage.find_by_id(params[:id])
  	if @static_page.update_attributes(static_page_params)
  		flash[:success] = I18n.t("general.update_a_page")
  		redirect_to admins_static_pages_path
  	else
  		render "back"
  	end
  end

  def destroy
    @static_page = StaticPage.find(params[:id])
    @static_page.destroy
    redirect_to admins_static_pages_path, notice: I18n.t("general.destroy_a_page")
  end  


  private
  
  def static_page_params
  	params.require(:static_page).permit(:name, :content, :page_route, :label)
  end

  def sort_column
    StaticPage.column_names.include?(params[:column]) ? params[:column] : (params[:column] ? params[:column] : "name")
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
