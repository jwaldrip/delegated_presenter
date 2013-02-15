module DelegatedPresenter::PresentsBeforeRendering
  extend ActiveSupport::Concern

  included do
    alias_method_chain :render, :presentation
  end

  private

  def presents_before_rendering
    from_singleton = self.singleton_class.presents_before_rendering
    from_class = self.class.presents_before_rendering
    from_singleton.present? ? from_singleton : from_class
  end

  # Presents specified instance variables before rendering.
  def render_with_presentation(*args, &block)
    presents_before_rendering.each do |var, options|
      next if (
        options.has_key?(:only) && !Array.wrap(options[:only]).include?(action_name.to_sym)
      ) || (
        options.has_key?(:except) && Array.wrap(options[:except]).include?(action_name.to_sym)
      ) || (ivar = instance_variable_get "@#{var}").blank?

      object_class = [ivar].flatten.collect(&:class).first.to_s
      presenter = options.fetch(:with, "#{object_class}Presenter").to_s.classify.constantize
      instance_variable_set "@#{var}", presenter.new(ivar)
    end
    render_without_presentation(*args, &block)
  end

  module ClassMethods

    def presents_before_rendering
      @presents_before_rendering ||= {} unless name == 'ActionController::Base'
    end

    private

    def inherited_with_presentation(subclass)
      subclass.instance_variable_set :@presents_before_rendering, presents_before_rendering
      super
    end

    # @!visibility public
    # Sets up a presenter for instance variables. By default it will try to determine the presenter but this can be overridden via the "*with*" option.
    # @overload presents(instance_var1, instance_var2, [...])
    #     Specifies which instance variables to present, assumes the presenter has a name of *InstanceClassPresenter*.
    #     @param instance_vars the instance variables to present.
    # @overload presents(instance_var1, instance_var2, [...], options)
    #     Specifies which instance variables to present, assumes the presenter has a name of *InstanceClassPresenter*.
    #     @param instance_vars the instance variables to present.
    #     @option options [Symbol] :with The presenter to use.
    #     @option options [Symbol] :only the only action to present on.
    #     @option options [Symbol] :except these actions to present on.
    def presents(*instance_vars)
      options                        = instance_vars.extract_options!
      instance_vars.each do |var|
        self.presents_before_rendering[var.to_sym] = options
      end
    end

    alias :present :presents

  end

end