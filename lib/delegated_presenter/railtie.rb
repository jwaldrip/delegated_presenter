class DelegatedPresenter::Railtie < Rails::Railtie

  generators do
    require "generators/delegated_presenter_generator"
  end

  initializer "Add presents before rendering to controller" do
    ActiveSupport.on_load :action_controller do
      ActionController::Base.send :include, DelegatedPresenter::PresentsBeforeRendering
    end
  end

end