class SimplePresenter::Railtie < Rails::Railtie

  generators do
    require "generators/simple_presenter_generator"
  end

end