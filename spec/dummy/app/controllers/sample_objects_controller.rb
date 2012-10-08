class SampleObjectsController < ApplicationController

  presents :instance, :collection
  presents :inherited_instance, with: SampleObjectPresenter

  def index
    @collection = SampleObject.all
    render text: true
  end

  def show
    @instance = SampleObject.find(params[:id])
    render text: true
  end

  def show_inherited
    @inherited_instance = InheritedSampleObject.find(params[:id])
    render text: true
  end

end
