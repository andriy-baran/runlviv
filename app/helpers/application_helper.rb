module ApplicationHelper
  def format_time(time_obj)
    time_obj.strftime('%d/%m/%Y %H:%M')
  end
end
