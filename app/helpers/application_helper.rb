module ApplicationHelper
  def flash_message(message, klass)
    tag.div(class: "alert alert-#{klass}") do
      concat raw(message)
    end
  end
end
