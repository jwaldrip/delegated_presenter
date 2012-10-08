require 'spec_helper'

describe SampleObjectPresenter do

  it '.presenter_method (full_name)' do
    object = FactoryGirl.create(:sample_object)
    presented_object = SampleObjectPresenter.new(object)
    expect(presented_object.full_name).to be_present
  end

  it '.model_instance_method (first_name)' do
    object = FactoryGirl.create(:sample_object)
    presented_object = SampleObjectPresenter.new(object)
    expect(presented_object.first_name).to be_present
  end

  it '#hide_method' do
    SampleObjectPresenter.send :hide, :id
    object = FactoryGirl.create(:sample_object)
    presented_object = SampleObjectPresenter.new(object)
    expect { presented_object.id }.to raise_error(DelegatedPresenter::Error::MethodHidden)
  end

  it '#expose_method' do
    SampleObjectPresenter.send :expose, :first_name
    object = FactoryGirl.create(:sample_object)
    presented_object = SampleObjectPresenter.new(object)
    expect { presented_object.id }.to raise_error(DelegatedPresenter::Error::MethodNotExposed)
    expect(presented_object.first_name).to be_present
  end

end
