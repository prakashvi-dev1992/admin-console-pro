module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"
    icon = column == sort_column ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe, params.merge(:column => column, :direction => direction, :page => nil),remote: :true    
  end

  def current_ability
    @current_ability ||= 
    case
     when current_user
       UserAbility.new(current_user)
     when current_admin
       AdminAbility.new
    end
  end
end
