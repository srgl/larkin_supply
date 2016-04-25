class LoadsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_load, only: [:show, :update, :download]
  authorize_resource

  def index
    @loads = Load.includes(:orders).ordered_by_date()
  end

  def show
    @orders = Order.ordered_by_ids_and_date(@load.order_ids)
  end

  def new
    @load = Load.new
    @orders = Order.ordered_by_date()
  end

  def create
    @load = Load.new(load_params)
    if @load.save
      return redirect_to load_url(@load)
    end
    @orders = Order.ordered_by_ids_and_date(@load.order_ids)
    render :new
  end

  def update
    if @load.update(load_params)
      return redirect_to load_url(@load)
    end
    @orders = Order.ordered_by_ids_and_date(@load.order_ids)
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
    @orders = Order.ordered_by_ids_and_date(@load.order_ids)
    pdf = render_to_string pdf: "#{@load.load_number}", layout: "pdf", template: "loads/show"
    send_data pdf, filename: "#{@load.load_number}.pdf"
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
