# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def page_header_tag(text)
    @page_title = strip_tags(text).strip
    content_tag(:h1, text)
  end
  
  def page_title_tag
    title = "Ando"
    title << " | #{current_blog.name}" if current_blog
    title << " | #{@page_title}" if @page_title
    content_tag(:title, title)
  end
  
  def records_found(collection,noun="record")
    return "No records found" if collection.empty?
    
    range_low = (collection.offset + 1)
    range_high =
      if (collection.per_page + collection.offset) > collection.total_entries
        collection.total_entries
      else
        (collection.per_page + collection.offset)
      end
    
    range = "#{range_low}-#{range_high}"
    
    "Showing #{range} of #{pluralize(collection.total_entries, noun)}"
  end
  
  def pages_found(collection)
    if collection.page_count > 0
      "Page #{collection.current_page} of #{collection.page_count}"
    end
  end
  
end
