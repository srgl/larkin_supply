class LoadsController < ApplicationController
  before_action :find_load, only: [:show, :update]

  def index
    @loads = Load.all
  end

  def show
    @orders = Order.all
  end

  def new
    @load = Load.new
  end

  def create
    if @load = Load.create(load_params)
      return redirect_to load_url(@load)
    end
    @orders = Order.all
    render :new
  end

  def update
    if @load.update(load_params)
      return redirect_to load_url(@load)
    end
    @orders = Order.all
    render :show
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
