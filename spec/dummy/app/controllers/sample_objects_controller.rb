class SampleObjectsController < ApplicationController

  def index
    @collection = SampleObject.all
    render text: "Hello World"
  end

  def show
    @instance = SampleObject.find(params[:id])
    render text: "Hello World"
  end

end
