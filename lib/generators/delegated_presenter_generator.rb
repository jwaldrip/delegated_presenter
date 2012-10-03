class DelegatedPresenterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def initialize(args, *options) #:nodoc:
    args[0] = args[0].gsub(/\./,'_')
    super
  end

  def create_presenter_file
    template "presenter.rb.erb", "app/presenters/#{file_name}_presenter.rb"
  end
end