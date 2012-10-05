module DelegatedPresenter::Error

  # Error raised when an object is not presentable.
  class NotPresentable < StandardError
  end

  # Error raised when a method is not exposed.
  class MethodNotExposed < StandardError
  end

  # Error raised when a method is not exposed.
  class MethodHidden < StandardError
  end

end