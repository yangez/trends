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
end
