class SampleObjectPresenter < DelegatedPresenter::Base

  # By default this presenter will try and present a `SampleObject` if it exists.
  # You can explicitly tell the presenter to present other models using the following syntax:

  presents InheritedSampleObject

  # Add some functionality to your presenter!
  # The presenter will always look to the model it is presenting for methods and attributes not defined in the presenter.
  # If you want to override model method, you can always call `presented_model.{method_name}` to access the original method.

end