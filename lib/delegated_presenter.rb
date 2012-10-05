require "delegated_presenter/version"

module DelegatedPresenter
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Error
  autoload :PresentsBeforeRendering

end

require 'delegated_presenter/railtie' if defined?(Rails)
