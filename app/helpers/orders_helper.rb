module OrdersHelper
  def order_title(order)
    order.purchase_order_number.blank? ? 'N/A' : order.purchase_order_number
  end

  def origin_address(order)
    "#{order.origin_raw_line_1}, #{order.origin_city}, #{order.origin_state} #{order.origin_zip}"
  end

  def destination_address(order)
    "#{order.destination_raw_line_1}, #{order.destination_city}, #{order.destination_state} #{order.destination_zip}"
  end

  def delivery_date(order)
    date = []
    date << order.delivery_date if order.delivery_date != nil
    date << "#{order.delivery_shift.humanize}" if order.delivery_shift != nil
    return date.join(" ")
  end

end
