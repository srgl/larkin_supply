class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to orders_url if current_user.dispatcher?
    redirect_to loads_url if current_user.driver?
  end
end
