require 'spec_helper'

describe SampleObjectsController, type: :controller do

  before do
    10.times { FactoryGirl.create(:sample_object) }
  end

  it 'presents @collection' do
    get :index
    expect(assigns(:collection).presenter_class).to eq(SampleObjectPresenter)
  end

  it 'presents @instance' do
    get :show, { id: 1 }
    expect(assigns(:instance).presenter_class).to eq(SampleObjectPresenter)
  end

end
