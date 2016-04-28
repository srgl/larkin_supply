class LoadsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_load, only: [:show, :update, :download]
  authorize_resource

  def index
    @loads = Load.includes(:orders).ordered_by_date()
  end

  def show
  end

  def new
    @load = Load.new
  end

  def create
    prefill_ordering

    @load = Load.new(load_params)
    if @load.save
      return redirect_to load_url(@load)
    end
    render :new
  end

  def update
    prefill_ordering

    if @load.update(load_params)
      return redirect_to load_url(@load)
    end
    render :show
  end

  def delete
    loads = Load.where(id: params[:ids])
    loads.delete_all
    respond_to do |format|
      format.json { render :json => { redirect: loads_url } }
    end
  end

  def download
    pdf = render_to_string pdf: "#{@load.load_number}", layout: "pdf", template: "loads/show", viewport_size: '1920x995'
    send_data pdf, filename: "#{@load.load_number}.pdf"
  end

  private

  def prefill_ordering
    params[:load][:orders_attributes] = []

    params[:load][:order_ids].each_with_index do |id, i|
      params[:load][:orders_attributes].push({id: id, order: i}) if !id.blank?
    end
  end

  def find_load
    @load = Load.includes(:orders).find(params[:id])
  end

  def load_params
    params.require(:load).permit(
      :delivery_date,
      :delivery_shift,
      order_ids: [],
      orders_attributes: [:id, :order])
  end
end
