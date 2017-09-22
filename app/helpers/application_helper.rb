module ApplicationHelper

  def date date, format = "%B %d, %Y"
    date.strftime(format)
  end
end
