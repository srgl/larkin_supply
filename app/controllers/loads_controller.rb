class LoadsController < ApplicationController
  before_action :find_load, only: [:edit, :update]

  def index
    @loads = Load.includes(:orders).ordered_by_date()
  end

  def edit
    @orders = Order.ordered_by_ids_and_date(@load.order_ids)
  end

  def new
    @load = Load.new
    @orders = Order.ordered_by_date()
  end

  def create
    @load = Load.new(load_params)
    if @load.save
      return redirect_to edit_load_url(@load)
    end
    @orders = Order.ordered_by_ids_and_date(@load.order_ids)
    render :new
  end

  def update
    if @load.update(load_params)
      return redirect_to edit_load_url(@load)
    end
    @orders = Order.ordered_by_ids_and_date(@load.order_ids)
    render :edit
  end

  def delete
    loads = Load.where(id: params[:ids])
    loads.delete_all
    respond_to do |format|
      format.json { render :json => { redirect: loads_url } }
    end
  end

  private

  def find_load
    @load = Load.includes(:orders).find(params[:id])
  end

  def load_params
    params.require(:load).permit(
      :delivery_date,
      :delivery_shift,
      { order_ids: [] })
  end
end
