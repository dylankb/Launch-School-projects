module ApplicationHelper
  def format_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end
end
