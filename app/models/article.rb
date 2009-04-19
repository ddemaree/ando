class Article < ActiveRecord::Base
  include Ando::ActsAsPostable
  
  belongs_to :blog
  
  validates_presence_of :title
  validates_presence_of :blog, :message => "must be specified"
  validates_presence_of :basename, :unless => Proc.new { |m| m.title.blank? }
  validates_uniqueness_of :basename, :unless => Proc.new { |m| m.title.blank? }
  validates_format_of :basename, :with => /[a-z0-9_]/, :message => "should consist only of lowercase letters, numbers or the underscore character", :unless => Proc.new { |m| m.title.blank? }
  
  before_validation :set_basename_if_blank
  
  def self.find_by_basename!(id_param)
    article = find_by_basename(id_param)
    raise RecordNotFound, "Couldn't find article with basename #{id_param}" if article.nil?
    article
  end
  
  def to_s
    title
  end
  
  def to_param
    basename || "#{id}-#{basename_from_title}"
  end
  
  def excerpt
    super.blank? ? excerpt_from_body : super
  end
  
  def excerpt_from_body
    if body.blank? then return end
    (body.chars.length > 140 ? body.chars[0...137] + "..." : body).to_s
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
    self.title.downcase.gsub(/[^a-z0-9_]+/, "_").gsub(/[^a-z0-9]+$/,"")
  end
  
end
