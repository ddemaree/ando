module Blrb::Routing
  VALID_KEYS = %w(:year :month :day :week :id :basename :tags :category)
  
  def self.convert_to_regexp(route)
    route.gsub!(/:(\w+)/) do
      param = $1.to_sym

      case param
        when :year then "\\d{4}"
        when :month, :week, :day then "\\d{2}"
        when :basename then "[a-z0-9_\-]+"
        when :id then "\\d+"
        when :tags, :category then "[^\/]+"
        else param
      end
    end
    
    return "^#{route}$"
  end
  
  def self.params_from_uri(uri,route)
    uri_params   = uri.split(/\//)
    route_params = route.split(/\//)
    
    route_params.inject({}) do |coll, key|
      index = route_params.index(key)
      coll[key.gsub(/^\:/,"").to_sym] = uri_params[index]
      coll
    end
  end
  
  def to_regexp
    Regexp.compile(self.cached_regexp)
  end

  def route_keys
    self.route.scan(/\:[a-z]+/)
  end

  def invalid_keys
    self.route_keys.reject { |key| VALID_KEYS.include?(key)  }
  end

  def params_from_uri(request_uri)
    Blrb::Routing.params_from_uri(request_uri, self.route)
  end

  def route_to_regexp_string
    route_regexp = Blrb::Routing.convert_to_regexp(self.route)
  end
  
private

  def cache_regexp_string
    self.cached_regexp = self.route_to_regexp_string unless self.route.blank?
  end

  def check_for_invalid_route_keys
    errors.add(:route, "contains invalid keys: #{self.invalid_keys.join(', ')}") unless self.invalid_keys.empty?
  end
  
end