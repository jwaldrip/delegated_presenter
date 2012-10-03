require "simple_presenter/version"

module SimplePresenter
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Error
end

require 'simple_presenter/railtie' if defined?(Rails)
