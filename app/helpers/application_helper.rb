module ApplicationHelper
  # Handles HTML title element
  def page_title(*titles)
    @page_title ||= []
    @page_title.push(*titles.compact) if titles.any?
    @page_title.join(" \u00b7 ") # Segments are separated by middot
  end
end
