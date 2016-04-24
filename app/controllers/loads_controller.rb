class LoadsController < ApplicationController
  before_action :find_load, only: [:edit, :update, :destroy, :orders]

  def index
    @loads = Load.all
  end

  def new
    @load = Load.new
  end

  def create
    @load = Load.new(load_params)
    if @load.save
      redirect_to edit_load_url(@load)
    else
      render :new
    end
  end

  def edit
    @orders = Order.all
  end

  def update
    @load.update(load_params)
    #redirect_to edit_load_url(@load)
    @orders = Order.all
    render :edit
  end

  def delete
    loads = Load.where(id: params[:ids])
    loads_count = loads.size
    loads.delete_all
    respond_to do |format|
      format.json { render :json => { redirect: loads_url } }
    end
  end

  private

  def find_load
    @load ||= Load.includes(:orders).find(params[:id])
  end

  def load_params
    params.require(:load).permit(
      :delivery_date,
      :delivery_shift,
      { order_ids: [] })
  end
end
