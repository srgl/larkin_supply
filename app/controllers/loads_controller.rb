class LoadsController < ApplicationController
  def index
    @loads = Load.all
  end
end
