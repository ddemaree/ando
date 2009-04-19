module WebsiteHelper
  
  def action
    @action = ActiveSupport::StringInquirer.new(action_name)
  end
  
  def page_title(tag=true)
    returning("") do |out|
      out << "#{strip_tags @section_title} &mdash; " if @section_title
      out << "#{strip_tags @page_title} &mdash; " if @page_title
      out << "Ando"
    end
  end

  def body_id
    @body_id ||= controller.controller_name.gsub(/[^a-zA-Z0-9_-]/,"-")
  end
  
  def body_classes
    action_name =
      case controller.action_name
        when "create" then "new"
        when "update" then "edit"
        else controller.action_name
      end
    
    @body_classes ||= [action_name]
  end
  
  def section_name
    @section_name ||= body_id
  end
  
end
