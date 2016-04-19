module OrdersHelper
  def order_title(order)
    order.purchase_order_number || 'N/A'
  end
end
