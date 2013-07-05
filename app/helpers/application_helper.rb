module ApplicationHelper
  def active_link?(path)
    current_path == path
  end
end
