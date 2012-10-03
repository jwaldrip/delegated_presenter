class DelegatedPresenter::Railtie < Rails::Railtie

  generators do
    require "generators/delegated_presenter_generator"
  end

end