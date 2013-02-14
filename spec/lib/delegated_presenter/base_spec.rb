require 'spec_helper'

describe DelegatedPresenter::Base do

  let(:object_class) do
    object_class = Class.new do

      def foo
        "foo"
      end

      def bar
        "bar"
      end

      def baz
        "baz"
      end

    end

    stub_const 'Foo', object_class
  end
  let(:object_instance) { object_class.new }
  let(:presenter) do
    object_class
    presenter = Class.new(DelegatedPresenter::Base) do
      presents :foo
    end
    stub_const 'FooPresenter', presenter
  end
  let(:presented_object){ presenter.new(object_instance) }

  describe '.hide' do
    let(:presenter) do
      object_class
      presenter = Class.new(DelegatedPresenter::Base) do
        presents :foo
        hide :foo
      end
      stub_const 'FooPresenter', presenter
    end
    context 'when a hidden method is called' do
      it 'should raise an error' do
        expect { presented_object.foo }.to raise_error DelegatedPresenter::Error::MethodHidden
      end
    end

    context 'when a non hidden method is called' do
      it 'should raise an error' do
        expect { presented_object.bar }.to_not raise_error DelegatedPresenter::Error::MethodHidden
      end
    end
  end

  describe '.expose' do
    let(:presenter) do
      object_class
      presenter = Class.new(DelegatedPresenter::Base) do
        presents :foo
        expose :foo
      end
      stub_const 'FooPresenter', presenter
    end
    context 'when a exposed method is called' do
      it 'should raise an error' do
        expect { presented_object.foo }.to_not raise_error DelegatedPresenter::Error::MethodNotExposed
      end
    end

    context 'when a non exposed method is called' do
      it 'should raise an error' do
        expect { presented_object.bar }.to raise_error DelegatedPresenter::Error::MethodNotExposed
      end
    end
  end

  describe '#class' do
    it "should be the model class" do
      presented_object.class.should == object_class
    end
  end

  describe '#model_instance_method (first_name)' do
    it 'Calls a method on the presenter' do
      presented_object.foo.should be_present
    end
  end

  describe '#model_instance_method (first_name)' do
    it 'calls an instance in the model' do
      presented_object.foo.should be_present
    end
  end

end
