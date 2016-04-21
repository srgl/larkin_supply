class LoadsController < ApplicationController
  before_action :find_load, only: [:edit, :update, :destroy]

  def index
    @loads = Load.all
  end

  def create
    @load = Load.create(load_params)
    respond_to do |format|
      format.json { render :json => { redirect: edit_load_url(@load) } }
    end
  end

  def edit
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
    @load ||= Load.find(params[:id])
  end

  def load_params
    params.require(:load).permit(
      :delivery_date,
      :delivery_shift,
      { order_ids: [] })
  end
end
