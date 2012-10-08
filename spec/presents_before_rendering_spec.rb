require 'spec_helper'

describe SampleObjectsController, type: :controller do

  before do
    10.times { FactoryGirl.create(:sample_object) }
    10.times { FactoryGirl.create(:inherited_sample_object) }
  end

  context "presents before rendering" do

    describe "#render (collection)" do
      it 'presents @collection' do
        get :index
        assigns(:collection).presenter_class.should eq(SampleObjectPresenter)
      end
    end

    describe "#render (instance)" do
      it 'presents @instance' do
        get :show, { id: SampleObject.first.id }
        assigns(:instance).presenter_class.should eq(SampleObjectPresenter)
      end
    end

    describe "#render (instance with specified presenter)" do
      it 'presents @with_presenter' do
        get :show_inherited, { id: InheritedSampleObject.first.id }
        assigns(:inherited_instance).presenter_class.should eq(SampleObjectPresenter)
      end
    end


  end

end
