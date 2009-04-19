class BlogContext < Radius::Context
  attr_reader :blog
  
  def initialize(blog)
    super()
    @blog = blog
    globals.blog = @blog

    blog.tags.each do |name|
      define_tag(name) { |tag_binding| blog.render_tag(name, tag_binding) }
    end
  end
  
end