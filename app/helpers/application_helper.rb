module ApplicationHelper
  def flash_message(message, klass)
    content_tag(:div, class: "alert alert-#{klass}") do
      concat raw(message)
    end
  end
end
