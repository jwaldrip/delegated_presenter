require 'spec_helper'

describe SampleObjectsController, type: :controller do

  let(:options){ {} }

  before do
    10.times { FactoryGirl.create(:sample_object) }
    controller.singleton_class.send :presents, :instance, :collection, options
  end

  it 'presents :collection' do
    get :index
    expect(assigns(:collection).presenter_class).to eq(SampleObjectPresenter)
  end

  it 'presents :instance' do
    get :show, { id: 1 }
    expect(assigns(:instance).presenter_class).to eq(SampleObjectPresenter)
  end

  context 'with options' do

    context 'given options[:with]' do

      let(:other_presenter) do
        klass = Class.new(DelegatedPresenter::Base) do
          presents SampleObject
        end
        stub_const("OtherPresenter", klass)
        klass
      end
      let(:options){ { with: other_presenter } }

      it 'should use the other presenter' do
        other_presenter.should_receive(:new)
        get :show, { id: 1 }
      end
    end

    context 'given options[:only]' do
      let(:options){ { only: :show } }

      it 'should only present on the specified actions' do
        SampleObjectPresenter.should_receive(:new).once.and_call_original
        get :show, { id: 1 }
      end

      it 'not present on actions not specified' do
        SampleObjectPresenter.should_receive(:new).never
        get :index
      end
    end

    context 'given options[:except]' do
      let(:options){ { except: :show } }

      it 'should not present on the specified actions' do
        SampleObjectPresenter.should_receive(:new).never
        get :show, { id: 1 }
      end
    end

  end

end
