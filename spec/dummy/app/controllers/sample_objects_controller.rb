class SampleObjectsController < ApplicationController

  presents :instance, :collection

  def index
    @collection = SampleObject.all
  end

  def show
    @instance = SampleObject.find(params[:id])
  end

end
