module DelegatedPresenter::PresentsBeforeRendering
  extend ActiveSupport::Concern

  included do
    class_attribute :presents_before_rendering
    self.presents_before_rendering = []
  end

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
  def self.presents(*instance_vars)
    options = instance_vars.extract_options!
    self.presents_before_rendering += instance_vars.flatten.map(&:to_s)
  end

  # Presents specified instance variables before rendering.
  def render
    presents_before_rendering.each do |var|
      ivar = instance_variable_get("@#{var}")
      if ivar.present?
        (var.classify + 'Presenter').constantize.new ivar
      end
    end

    super
  end

end