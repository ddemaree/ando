class Tag < ActiveRecord::Base
  has_many :taggings

  def self.parse(list)
    
    # Add support for arrays, which would be coming from a JS tag builder
    if list.is_a?(Array)
      return list.collect(&:strip).delete_if(&:empty?).uniq
    end
    
    # If tag list includes commas, use those as the delimiter
    if list =~ /, */
      return list.split(/, */).delete_if(&:empty?).uniq
    end
    
    tag_names = []

    # first, pull out the quoted tags
    list.gsub!(/\"(.*?)\"\s*/ ) { tag_names << $1; "" }

    # then, replace all commas with a space
    list.gsub!(/,/, " ")

    # then, get whatever's left
    tag_names.concat list.split(/\s/)

    # strip whitespace from the names
    tag_names = tag_names.map { |t| t.strip }

    # delete any blank tag names
    tag_names = tag_names.delete_if { |t| t.empty? }
    
    return tag_names
  end

  def tagged
    @tagged ||= taggings.collect { |tagging| tagging.taggable }
  end
  
  def on(taggable)
    taggings.create :taggable => taggable
  end
  
  def ==(comparison_object)
    super || name == comparison_object.to_s
  end
  
  def to_s
    name
  end
end