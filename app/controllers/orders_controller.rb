class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def import
    if request.post?
      result = ImportOrders.new.run(params[:file])
      redirect_to orders_url, notice: "Import finished, #{result} orders created"
    end
  end
end
