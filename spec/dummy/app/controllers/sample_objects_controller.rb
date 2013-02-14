class SampleObjectsController < ApplicationController

  def index
    @collection = SampleObject.all
  end

  def show
    @instance = SampleObject.find(params[:id])
  end

end
