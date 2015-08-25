module ApplicationHelper

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def sub_title(sub_title)
    content_for :sub_title, content_tag(:span, sub_title.to_s, class: "content-subtitle")
  end
end