atom_feed do |feed|
  feed.title "Articles"
  feed.updated Article.minimum(:created_at)
  
  for article in @articles
    feed.entry(article) do |entry|
      entry.title(article.title)
      entry.content(article.body, :type => 'html')
      entry.link :type => "application/atom+xml", :href => admin_article_url(:id => article, :format => :atom), :rel => "edit"
      entry.tag!('app:edited', Time.now)
      entry.author do |author|
        author.name('David Ellen Nemesis')
      end
    end
  end
end