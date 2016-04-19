class OrdersController < ApplicationController
  before_action :find_order, only: [:edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    if @order = Order.create(order_params)
      flash[:notice] = "Order created"
      redirect_to edit_order_url(@order)
    end
    render :new
  end

  def edit
  end

  def update
    if @order.update(order_params)
      flash[:notice] = "Order updated"
    end
    redirect_to edit_order_url(@order)
  end

  def destroy
    @order.destroy
    redirect_to action: :index
  end

  def import
    if request.post?
      result = ImportOrders.new.run(params[:file])
      redirect_to action: :index, notice: "Import finished, #{result} order(s) created"
    end
  end

  private

  def find_order
    @order ||= Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :purchase_order_number,
      :delivery_date,
      :delivery_shift,
      :origin_name,
      :origin_raw_line_1,
      :origin_city,
      :origin_state,
      :origin_zip,
      :origin_country,
      :client_name,
      :destination_raw_line_1,
      :destination_city,
      :destination_state,
      :destination_zip,
      :destination_country,
      :phone_number,
      :mode,
      :volume,
      :handling_unit_quantity,
      :handling_unit_type)
  end
end
