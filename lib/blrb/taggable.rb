module Blrb::Taggable
  mattr_accessor :last_description, :tag_descriptions
  @@tag_descriptions = {}
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def render_tag(name, tag_binding)
    send "tag:#{name}", tag_binding
  end
  
  def tags
    Util.tags_in_array(methods)
  end
  
  
  module ClassMethods
    def tag(name, &block)
      define_method("tag:#{name}", &block)
    end
 
    def tags
      Util.tags_in_array(self.instance_methods)
    end
 
  end
 
  module Util
    def self.tags_in_array(array)
      array.grep(/^tag:/).map { |name| name[4..-1] }.sort
    end
 
    def self.strip_leading_whitespace(text)
      text = text.dup
      text.gsub!("\t", "  ")
      lines = text.split("\n")
      leading = lines.map do |line|
        unless line =~ /^\s*$/
           line.match(/^(\s*)/)[0].length
        else
          nil
        end
      end.compact.min
      lines.inject([]) {|ary, line| ary << line.sub(/^[ ]{#{leading}}/, "")}.join("\n")
    end     
 
  end
  
end