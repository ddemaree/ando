#xml.instruct!
xml.entry :xmlns => "http://www.w3.org/2005/Atom", "xmlns:app" => "http://www.w3.org/2007/app", "xml:lang" => "" do
  #xml.id "tag:#{request.host},2005:#{entry.class}/#{entry.id}"
  xml.id    article_url(entry)
  xml.title entry.title, :type => "text"
  xml.updated entry.updated_at(:rfc822)
  xml.author do
    xml.name "David Ellen Nemesis"
  end
  xml.content entry.body, :type => "text"
  xml.summary entry.excerpt, :type => "text"
  xml.link :href => article_url(entry)
  xml.link :href => admin_article_url(:id => entry, :format => :atom), :rel => "edit" 
end