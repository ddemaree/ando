class Item < ActiveRecord::Base
  # TODO: Item is deprecated, need to move some of this logic to Article, et al
  
  belongs_to :blog
  belongs_to :kind
  validates_presence_of :body, :title
  
  alias_attribute :slug, :basename
  alias_attribute :description, :excerpt
  
  
  def publish_status=(pstat)
    self.status =
      case pstat
        when "1" then "published"
        when "0" then "draft"
        else "mysterious"
      end
  end
  
  def author=(name)
    # Do nothing, we'll deal with this author crap later
  end
  alias_method :tags=, :author=
  
  alias_attribute :published_on, :created_at
  
  def self.conditions_for_params(params)
    if params.keys.include?(:id)
      return "items.id = '#{params[:id]}'"
    elsif params.keys.include?(:basename)
      return "items.basename = '#{params[:basename]}'"
    end
    
    params.inject([]) do |coll, param|
      key, value = *param      
      coll <<
        case key
          when :year, :month, :week, :day
            "#{key.to_s.upcase}(items.created_at) = '#{value}'"
          when :basename, :id
            "items.#{key.to_s} = '#{value}'"
        end
      coll
    end.join(" AND ")
  end
  
end
