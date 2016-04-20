module OrdersHelper
  def order_title(order)
    order.purchase_order_number.blank? ? 'N/A' : order.purchase_order_number
  end
end
