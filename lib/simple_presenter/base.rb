class SimplePresenter::Base < SimpleDelegator

  @@presentable = {}

  def initialize(object)
    raise Presenter::NotPresentable, "#{self.presenter_class} cannot present a #{object.class}" unless self.presentable.include?(object.class.name)
    super(object)
    freeze
  end

  alias_method :presenter_class, :class

  def class
    __getobj__.class
  end

  def presentable
    (@@presentable[self.presenter_class.name] || [])
  end

  def self.presents(*objects)
    @@presentable[name] ||= []
    @@presentable[name] += objects.flatten.collect{ |i| i.to_s.camelize.singularize }
  end

  def self.inherited(subclass)
    presentable_class = sublclass.name.gsub(/Presenter$/)
    subclass.presents presentable_class if Object.const_defined?(presentable_class)
  end

end