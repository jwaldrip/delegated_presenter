module DelegatedPresenter::PresentsBeforeRendering
  extend ActiveSupport::Concern

  included do
    class_attribute :presents_before_rendering
    self.presents_before_rendering = {}
  end

  private

  # Presents specified instance variables before rendering.
  def render(*args)
    presents_before_rendering.each do |var, presenter|
      ivar = instance_variable_get("@#{var}")
      if ivar.present?
        object_class = [ivar].flatten.collect(&:class).first.to_s
        presenter = (object_class + 'Presenter') if presenter.empty?
        instance_variable_set("@#{var}", presenter.constantize.new(ivar))
      end
    end

    super(*args)
  end

  module ClassMethods

    private

    # @!visibility public
    # Sets up a presenter for instance variables. By default it will try to determine the presenter but this can be overridden via the "*with*" option.
    # @overload presents(instance_var1, instance_var2, [...])
    #     Specifies which instance variables to present, assumes the presenter has a name of *InstanceClassPresenter*.
    #     @param instance_vars the instance variables to present.
    # @overload presents(instance_var1, instance_var2, [...], options)
    #     Specifies which instance variables to present, assumes the presenter has a name of *InstanceClassPresenter*.
    #     @param instance_vars the instance variables to present.
    #     @option options [Symbol] :with The presenter to use.
    def presents(*instance_vars)
      options = instance_vars.extract_options!
      instance_vars.flatten.each do |instance_var|
        self.presents_before_rendering.merge!({ instance_var.to_sym => options[:with].to_s })
      end
    end

    alias :present :presents

  end

end