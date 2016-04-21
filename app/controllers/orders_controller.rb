class OrdersController < ApplicationController
  before_action :find_order, only: [:edit, :update]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    if @order = Order.create(order_params)
      flash[:notice] = "Order created"
      return redirect_to edit_order_url(@order)
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

  def import
    if request.post?
      begin
        @result = ImportOrders.new.run(params[:file], method(:permit_params))
      rescue Exception => e
        flash.now[:alert] = e.message
      end
    end
  end

  def delete
    orders = Order.where(id: params[:ids])
    orders_count = orders.size
    orders.delete_all
    respond_to do |format|
      format.json { render :json => { redirect: orders_url } }
    end
  end

  private

  def find_order
    @order ||= Order.find(params[:id])
  end

  def order_params
    permit_params(params)
  end

  def permit_params(params)
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
