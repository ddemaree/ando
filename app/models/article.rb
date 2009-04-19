class Article < ActiveRecord::Base
  FakeTitleLength = 59
  
  include Ando::ActsAsPostable
  #include Ando::Publishing
  
  validates_presence_of :title, :if => :published?
  validates_presence_of :basename, :unless => Proc.new { |m| m.title.blank? }
  validates_uniqueness_of :basename, :unless => Proc.new { |m| m.title.blank? }
  validates_format_of :basename, :with => /\A[a-z0-9_]+\Z/, :message => "should consist only of lowercase letters, numbers or the underscore character", :unless => Proc.new { |m| m.title.blank? }
  
  before_validation :set_basename_if_blank
  
  # For Atompub compatibility
  alias_attribute :summary, :description
  alias_attribute :content, :body
  attr_accessor :generator
  attr_accessor :xmlns
  
  # For Atompub compatibility
  def control=(params={})
    params.each do |key, value|
      case key
        when "draft"
          self.status = (value == "no" ? "published" : "draft")
      end
    end
  end
  
  
  def self.find_by_basename!(id_param)
    article = find_by_basename(id_param)
    raise RecordNotFound, "Couldn't find article with basename #{id_param}" if article.nil?
    article
  end
  
  def to_s
    title
  end
  
  def to_name
    display_title
  end
  
  def to_param
    "#{id}-#{basename_from_title}"
  end
  
  # OPTIMIZE: Better name for real_excerpt method?
  def excerpt
    super.blank? ? excerpt_from_body : super
  end
  
  def display_title
    (title unless title.blank?) ||
     title_from_body ||
     "Untitled"
  end
  
  def title_from_body
    return nil if body.blank?
    "#{body.first(FakeTitleLength)}#{"…" if body.length > FakeTitleLength}"
  end
  
  def excerpt_from_body
    if body.blank? then return end
    (body.length > 140 ? body[0...137] + "..." : body).to_s
  end
  
  def to_atom
    
  end
  
protected

  def set_basename_if_blank
    return true unless self.basename.blank?
    return true if self.title.blank?
    
    unless self.class.find_by_basename(self.basename_from_title)
      self.basename = self.basename_from_title
      return true
    end
    
    index = 1
    begin
      self.basename = "#{self.basename_from_title}_#{index}"
      index += 1
    end while !self.class.find_by_basename(self.basename).nil?
  end
  
  def basename_from_title
    self.title.to_s.downcase.gsub(/[^a-z0-9_]+/, "_").gsub(/[^a-z0-9]+$/,"")
  end
  
end
