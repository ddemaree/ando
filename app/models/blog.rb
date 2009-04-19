class Blog < ActiveRecord::Base
  
  include Blrb::Taggable
  include PostTags
  
  class UnrouteableError < Exception; end
  class PartialNotFound < Exception; end
  
  attr_accessor :params, :scope
  
  has_many :postables
  has_many :articles
  has_many :links
  
  has_many :items
  has_many :kinds
  
  has_many :templates, :conditions => "templates.type != 'Partial'"
  has_many :indexes, :class_name => "Template::Index"
  has_many :partials, :class_name => "Template::Partial"
  
  def self.find_by_basename!(id_param)
    blog = find_by_basename(id_param)
    raise RecordNotFound, "Couldn't find blog with basename #{id_param}" if blog.nil?
    blog
  end
  
  def to_s
    name
  end
  
  def to_param
    basename
  end
  
  def route(request_uri)
    routeable = find_index_or_mapping(request_uri)
    raise UnrouteableError, "no matching route found for #{request_uri}" unless routeable
    [nil, routeable]
  end
  
  def find_template_by_route(request_uri)
    self.templates.select do |index|
      (request_uri =~ index.to_regexp)
    end.first
  end
  alias_method :find_template, :find_template_by_route
  alias_method :find_index_or_mapping, :find_template_by_route
  alias_method :find_mapping, :find_template_by_route
  
  def render(request_uri)
    mapping, template = self.route(request_uri)
    logger.info("Rendering with #{mapping.inspect}, #{template.inspect}")
    render_template(template.content)
  end
  
  def render_template(content)
    self.parser.parse(content)
  end
  
  # Right now, assume obj is a Template::Partial
  def render_object(obj)
    self.parser.parse(obj.content)
  end
  
  def parser
    @parser ||= Radius::Parser.new(self.context, :tag_prefix => "blrb")
  end
  
  def context
    @context ||= BlogContext.new(self)
  end
  
  def params_for_context(attrs={})
    {
      :sort_by => attrs["sort_by"] || "created_at",
      :sort_order => attrs["sort_order"] || "desc",
      :limit => attrs["limit"] || attrs["lastn"] || "20"
    }
  end
  
end
