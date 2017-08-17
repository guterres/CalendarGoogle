module EventsHelper
  def print_times(start, ending)
    if start.date
      start_str = start.date
    elsif start.date_time
      start_str = start.date_time.strftime("%d/%m/%Y (%H:%M)")
    end

    if ending.date
      end_str = ending.date
    elsif ending.date_time
      end_str = ending.date_time.strftime("%d/%m/%Y (%H:%M)")
    end

    content_tag :div do
      concat(content_tag('span', start_str, class: 'badge')) if start_str
      concat(content_tag('strong', ' - ')) if start_str && end_str
      concat(content_tag('span', end_str, class: 'badge')) if end_str
    end
  end

  def print_location(location)
    if location
      content_tag :div, class: 'form-inline' do
        concat(content_tag('label', 'Location: '))
        concat(content_tag('span', location))
      end
    end
  end

  def print_summary(summary)
    content_tag('h4', summary) if summary
  end

  def print_description(description)
    if description
      content_tag :div, class: 'well well-sm' do
        concat(content_tag('span', description))
      end
    end
  end
end
