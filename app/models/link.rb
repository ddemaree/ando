class Link < ActiveRecord::Base
  include Ando::ActsAsPostable
  include Ando::Publishing
  
  ProtocolRegex = /\A([a-z]+)\:\/\/.+/
  
  before_validation :normalize_url_if_protocol_is_absent
  
  validates_presence_of :title, :url
  validates_format_of :url, :with => ProtocolRegex
  
  def to_s
    title
  end
  
  def link_type
    self.normalize_url_if_protocol_is_absent
    return nil if self.url.blank?
    
    case self.url
      when /(?:itunes|phobos).apple.com/ then :itunes
      else self.url.gsub(ProtocolRegex,"\\1").to_sym
    end
  end

protected

  def normalize_url_if_protocol_is_absent
    return true if self.url =~ /\A[a-z]+\:\/\/.+/
    self.url = "http://#{self.url}"
  end
  
  def method_missing_with_link_type_queries(name,*args)
    if name.to_s =~ /_link\?$/
      expected_link_type = name.to_s.gsub(/_link\?/,"")
      return self.link_type == expected_link_type.to_sym
    else
      method_missing_without_link_type_queries(name,*args)
    end 
  end
  alias_method_chain :method_missing, :link_type_queries
  
end
