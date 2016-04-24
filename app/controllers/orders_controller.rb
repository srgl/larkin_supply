class OrdersController < ApplicationController
  before_action :find_order, only: [:edit, :update]

  def index
    @orders = Order.ordered_by_date
  end

  def edit
  end


  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      return redirect_to edit_order_url(@order)
    end
    render :new
  end

  def update
    if @order.update(order_params)
      return redirect_to edit_order_url(@order)
    end
    render :edit
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
    orders.delete_all
    respond_to do |format|
      format.json { render :json => { redirect: orders_url } }
    end
  end

  private

  def find_order
    @order = Order.find(params[:id])
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
