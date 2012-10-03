require "delegated_presenter/version"

module DelegatedPresenter
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Error
end

require 'delegated_presenter/railtie' if defined?(Rails)
