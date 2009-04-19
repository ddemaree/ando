module PostTags
  include Blrb::Taggable

  tag "partial" do |tag|
    partial = tag.locals.blog.partials.find_by_name(tag.attr["name"].strip)
    raise Blog::PartialNotFound, "couldn't find partial #{tag.attr["name"]}" if partial.nil?
    tag.locals.blog.render_object(partial)
  end
  
  tag "blog" do |tag|
    tag.locals.blog = Blog.find_by_name(tag.attr["name"]) || tag.globals.blog
    
    if tag.single?
      tag.locals.blog.name
    else
      old_blog = tag.globals.blog
      tag.globals.blog = Blog.find_by_name(tag.attr["name"])
      
      content = tag.expand
      tag.globals.blog = old_blog
      content
    end
  end
  
  [:name, :id].each do |method|
    tag "blog:#{method}" do |tag|
      tag.locals.blog.send(method)
    end
  end
  
  tag "posts" do |tag|
    tag.locals.blog ||= tag.globals.blog
    
    tag_params = tag.locals.blog.params_for_context(tag.attr)
    
    tag.locals.posts = tag.locals.blog.items.find(:all, {
      :conditions => tag.locals.blog.scope,
      :order => "#{tag_params[:sort_by]} #{tag_params[:sort_order]}",
      :limit => tag_params[:limit]
    })
    
    tag.locals.posts.inject("") do |content, post|
      tag.locals.post = post
      content << tag.expand
    end
  end
  
  tag "post" do |tag|
    tag.locals.post = tag.locals.blog.items.find(:first, {
      :conditions => tag.locals.blog.scope
    })
    tag.expand
  end
  
  [:title, :body, :body_html, :id].each do |method|
    tag "posts:#{method}" do |tag|
      tag.locals.post.send(method)
    end
    
    tag "post:#{method}" do |tag|
      tag.locals.post.send(method)
    end
  end
  
  tag "posts:if" do |tag|
    tag.expand if post_attribute_matches(tag)
  end
  
  tag "posts:unless" do |tag|
    tag.expand unless post_attribute_matches(tag)
  end
  
  tag "posts:switch" do |tag|
    tag.locals.switch_key = tag.attr["on"]
    tag.expand
  end
  
  tag "posts:switch:when" do |tag|
    value = tag.attr["value"]
    post_value = tag.locals.post.send(tag.locals.switch_key)
    if post_value.to_s == value.to_s
      tag.expand
    end
  end
  
  def post_attribute_matches(tag)
    key = tag.attr.keys.first
    value = tag.attr[key]
    (tag.locals.post.send(key).to_s == value.to_s)
  end

end