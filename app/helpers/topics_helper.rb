module TopicsHelper
  def percentage(decimal, params={precision: 2})
    number_to_percentage(decimal * 100, params)
  end

  def positive_negative_color_class(number)
    return if number.nil?
    if number > 0
      'text-success'
    elsif number < 0
      'text-danger'
    end
  end

  def delta_indicator(delta)
    color = delta >= 0 ? 'delta-positive' : 'delta-negative'
    content_tag :small, class: "delta-indicator #{color}" do
      number_to_percentage delta*100, precision: 0
    end
  end

end
