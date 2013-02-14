# @abstract Inherit from it to create a presenter.
# @raise [DelegatedPresenter::Error::MethodHidden]
#    If a method is specified as hidden.
# @raise [DelegatedPresenter::Error::MethodNotExposed]
#    If a method is not exposed.
class DelegatedPresenter::Base < SimpleDelegator

  delegate :exposed_methods, :hidden_methods, :presentable, to: :presenter_class

  alias :presented_model :__getobj__

  class << self

    attr_writer :presentable, :hidden_methods, :exposed_methods

    protected

    # Presentable Objects
    # @api private
    def presentable
      @presentable ||= [] unless name == 'DelegatedPresenter::Base'
    end

    # Methods to hide
    # @api private
    def hidden_methods
      @hidden_methods ||= [] unless name == 'DelegatedPresenter::Base'
    end

    # Methods to expose
    # @api private
    def exposed_methods
      @exposed_methods ||= [] unless name == 'DelegatedPresenter::Base'
    end

    private

    # Determine what objects what to present.
    # @!visibility public
    # @param :objects One or more models to be presented.
    # @example Add some presentable objects:
    #     presents :contact, :user, :client
    def presents(*objects)
      self.presentable += objects.flatten.collect{ |i| i.to_s.camelize.singularize }
    end

    # @!visibility public
    # Hide methods from the presenter.
    # @param methods one ore more methods from the model to hide from the presenter.
    # @example Hide methods:
    #     hide :id, :crypted_password, :password_salt
    def hide(*hidden_methods)
      self.hidden_methods += hidden_methods
    end

    # @!visibility public
    # Exposes methods to the presenter, when defined all others will be hidden.
    # @param :methods one ore more methods from the model to expose from the presenter.
    # @example Expose methods:
    #     expose :first_name, :last_name
    def expose(*exposed_methods)
      self.exposed_methods += exposed_methods.flatten
    end

    ## Internal Methods: Not Documented

    # @api private
    def inherited(subclass)
      subclass.instance_variable_set :@presentable, @presentable
      subclass.instance_variable_set :@hidden_methods, @hidden_methods
      subclass.instance_variable_set :@exposed_methods, @exposed_methods
      return unless subclass.name.present?
      presentable_class = subclass.name.gsub(/Presenter$/,'')
      presentable_class.constantize rescue nil
      subclass.send :presents, presentable_class if Object.const_defined?(presentable_class)
    end

  end

  # Initializes the presenter with an object.
  # @param object Can be an collection or instance of a presentable models.
  # @raise [DelegatedPresenter::Error::NotPresentable] if the object is not instance or collection
  #   of a presentable model.
  def initialize(object)
    if object.is_a?(Array)
      map_array(object)
    else
      raise DelegatedPresenter::Error::NotPresentable, "#{self.presenter_class} cannot present a #{object.class}" unless object_is_presentable?(object)
      __setobj__(object)
      if exposed_methods.present?
        expose_methods
      elsif hidden_methods.present?
        hide_methods
      end
    end
  end

  # The class of the presenter.
  alias_method :presenter_class, :class

  # The class of the presented object.
  def class
    presented_model.class
  end

  private

  # Raises an error when hidden methods are called.
  # @api private
  def hide_methods
    hidden_methods.flatten.each do |i|
      singleton_class.send :define_method, i do |*args|
        raise DelegatedPresenter::Error::MethodHidden, "Method `#{i} is hidden."
      end
    end
  end

  # Hides all methods except the ones exposed
  # @api private
  def expose_methods
    (unique_model_methods - exposed_methods).flatten.each do |i|
      singleton_class.send :define_method, i do |*args|
        raise DelegatedPresenter::Error::MethodNotExposed, "Method `#{i} is not exposed."
      end
    end
  end

  # Determines if an object is presentable
  # @api private
  def object_is_presentable?(object)
    presentable.include?(object.class.name)
  end

  # Extracts the the models unique methods from the superclass
  # @api private
  def unique_model_methods
    presented_model.methods - presented_model.class.superclass.instance_methods
  end

  # Maps an array of instances to delegated presented instances
  # @api private
  def map_array(array)
    array.map!{ |object| presenter_class.new(object) }
    inherited_methods = presenter_class.instance_methods - DelegatedPresenter::Base.instance_methods
    inherited_methods.each { |i| singleton_class.send(:undef_method, i) }
    __setobj__ array
  end

end