require "delegated_presenter/version"
require 'delegate'
require "active_support/concern"
require "active_support/dependencies/autoload"
require "active_support/core_ext/module/delegation"
require "active_support/inflector"

module DelegatedPresenter
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Error
  autoload :PresentsBeforeRendering

end

require 'delegated_presenter/railtie' if defined?(Rails)
