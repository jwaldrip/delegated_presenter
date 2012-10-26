# DelegatedPresenter

[![Build Status](https://secure.travis-ci.org/jwaldrip/delegated_presenter.png)](http://travis-ci.org/jwaldrip/delegated_presenter)

DelegatedPresenter gives you an easy way to present objects and collections to your models. It uses ruby's Delegate model so it is lightweight and functional!

## Installation

Add this line to your application's Gemfile:

    gem 'delegated_presenter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install delegated_presenter

## Usage

### Generate a presenter using a rails generator:

    $ rails g delegated_presenter contact

### Add some functionality to your presenter

```ruby
class ContactPresenter < DelegatedPresenter::Base
  # By default this presenter will try and present a Contact if it exists.
  # You can explicitly tell the presenter to present other models using the following syntax:

  presents OtherContact, SomeOtherModel

  # Add some functionality to your presenter!
  # The presenter will always look to the model it is presenting for methods and attributes not defined in the presenter.
  # If you want to override model method, you can always call `presented_model.{method_name}` to access the original method.

  def middle_initial
    "#{middle_name.first}." if middle_name
  end

  def full_name
    [prefix, first_name, middle_initial, last_name, suffix].compact.join(' ')
  end
end
```

### Hide or expose methods from the presented model:

There are two helper methods in the presenter.

* ```expose: :method_name, :another_method_name``` will hide all methods except the ones you specify.
* ```hide: :method_name, :another_method_name``` will only hide the methods you specify.

```ruby
class ContactPresenter < DelegatedPresenter::Base
  hide :id, :crypted_password
end
```

or:

```ruby
class ContactPresenter < DelegatedPresenter::Base
  expose :first_name, :last_name
end
```


### Use the controller helper
See: {DelegatedPresenter::PresentsBeforeRendering}

Use the following to present a model instance or collection with a presenter, by default it will try and use a presenter with the same class as the instance or collection.

```ruby
class ContactsController < ApplicationController
  presents :contact
end
```


If you for any reason need to explicitly define the presenter you may define a ```with: :presenter_name``` option, like so.

```ruby
class UsersController < ApplicationController
  presents :user, with: :contact_presenter
end
```


### Using the Presenter without the controller helper:

```ruby
class ContactsController < ApplicationController
  def index
    @contacts = ContactPresenter.new Contact.all
  end

  def show
    @contact = ContactPresenter.new Contact.find(params[:id])
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
