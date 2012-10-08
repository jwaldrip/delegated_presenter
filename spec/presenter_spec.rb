require 'spec_helper'

class SpecObject
  
  attr_accessor :exposed_attr, :hidden_attr, :model_instance_method
  
end

class SpecObjectPresenter < DelegatedPresenter::Base
  
  def presenter_method   
  end

end

class SpecObjectWithHiddenPresenter < DelegatedPresenter::Base
  
  presents SpecObject
  hide :hidden_attr

end

class SpecObjectWithExposedPresenter < DelegatedPresenter::Base

  presents SpecObject
  expose :exposed_attr

end

describe SpecObjectPresenter do

  let(:object) { SpecObject.new }
  subject{ SpecObjectPresenter.new(object) }

  context "presenter method" do
    it '#presenter_method' do
      subject.respond_to?(:presenter_method).should == true
    end
  end

  context "model instance method" do
    it '#model_instance_method' do
      subject.respond_to?(:model_instance_method).should == true
    end
  end

end

describe SpecObjectWithHiddenPresenter do

  describe '.hide' do
    it "should hide methods" do
      SpecObjectWithHiddenPresenter.hidden_methods.include?(:hidden_attr).should == true
    end
  end

  context 'hides methods' do
    let(:object) { SpecObject.new }
    subject { SpecObjectWithHiddenPresenter.new(object) }

    describe '#hidden_attr' do
      it "should raise an error" do
        expect{ subject.hidden_attr }.to raise_error(DelegatedPresenter::Error::MethodHidden)
      end
    end

    describe '#model_instance_method' do
      it "should not raise an error" do
        expect{ subject.model_instance_method }.to_not raise_error(DelegatedPresenter::Error::MethodHidden)
      end
    end

  end

end


describe SpecObjectWithExposedPresenter do

  describe '.expose' do
    it "should expose methods" do
      SpecObjectWithExposedPresenter.exposed_methods.include?(:exposed_attr).should == true
    end
  end

  context 'exposes methods' do
    let(:object) { SpecObject.new }
    subject { SpecObjectWithExposedPresenter.new(object) }

    describe '#exposed_attr' do
      it "should not raise an error" do
        expect{ subject.exposed_attr }.to_not raise_error(DelegatedPresenter::Error::MethodNotExposed)
      end
    end

    describe '#model_instance_method' do
      it "should raise an error" do
        expect{ subject.model_instance_method }.to raise_error(DelegatedPresenter::Error::MethodNotExposed)
      end
    end

  end

end
