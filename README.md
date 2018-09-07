# ActiveResponse

<a href="https://travis-ci.org/ontola/active_response"><img src="https://travis-ci.org/ontola/active_response.svg?branch=master" alt="Build Status"></a>

## About

DRY your controllers and make your API more predictable by defining responders for different formats. E.g. Posting an invalid resource in HTML should render a form with errors, while in JSON you expect serialized errors.
    
This was built at [Ontola](https://ontola.io/). If you want to know more about our passion for open data, send us [an e-mail](mailto:ontola@argu.co).

## Installation

Add this line to your application's Gemfile:

```
gem 'active_response'
```

And then execute:

```
$ bundle
```

## Work in progress
This gem is still in development. Better documentation will be added later. 

The gem is not yet tested, but is used in our apps which have broad test coverage. Tests for this gem will be written later.

## The concept
ActiveResponse separates a controller action in two concepts: the execution and the responder.

### The execution
First, the action is executed. For example, a resource will be created or deleted. 

Defining an execution is conditional. GET requests like show or new usually don't do anything other than fetching one or more resources from the database.

Dependending on the result of the action, the server should send a response to the client. You can choose from the available response types.

### The responder
Depending on the requested format, a Responder (e.g. the HTMLResponder), is selected and will process the response type.

## Examples

### \#show_success
```ruby
respond_with_resource(include: show_includes, locals: show_view_locals, resource: current_resource)
```
The HTMLResponser will render the show view, while the JSONResponder will render the resource as json.

### \#update_success
```ruby
respond_with_updated_resource(resource: current_resource, location: update_success_location, notice: active_response_success_message)
```
After updating a resource, the HTMLResponder will redirect to the resource, while the JSONResponder will render the updated resource.

### \#update_failure
```ruby
respond_with_updated_resource(resource: current_resource)
```
When updating a resource failed, the HTMLResponder will render a form with errors, while the JSONResponder will return the errors in json.

When you wish to be able to respond to new formats, all you need to do is to define a new Responder and tell how it should respond to different response types.

## Current resource
ActiveResponse adds the method current_resource to your controller. 
This methods is used to identify the resource which is primary in your request.
In new and create actions, this method will initialize a new instance of the model associated with the controller. 
In index it will remain empty, since multiple resources are requested.
In all other actions, it will try to find a resource by `params[:id]`.

## Getting started
First, include ``ActiveResponse::Controller`` in your controller:
```ruby
class ApplicationController < ActionController::Base
  include ActiveResponse::Controller
end
```

Then tell the controller which actions should be handled by ActiveResponse:
```ruby
active_response :new, :create, :show
```

Or add `create`, `destroy`, `edit`, `index`, `new`, `show`, `update` at once:
```ruby
active_response :crud
```

Now we need to add Responders to our application. For example, add `app/responders/html_responder.rb`. 
The gem includes predefined responders for html, json, js and json_api. 
Inherit from these and tell ActiveResponse for which formats this responder should be selected. 

```ruby
require 'active_response/responders/html'

class HTMLResponder < ActiveResponse::Responders::HTML
  respond_to :html
end
```

## Default response types
The following response types are available by default:
```
method                         by default used at:
respond_with_collection        index_success.
respond_with_destroyed         destroy_success.
respond_with_form              new_success and edit_success.
respond_with_invalid_resource  create_failure, update_failure and destroy_failure.
respond_with_new_resource      create_success.
respond_with_redirect          only used by the HTMLResponder.
respond_with_resource          in show_success and by some responders.
respond_with_updated_resource  in update_success.
```

## Customization
The gem is written in such a way that full customization is possible by overwriting methods in your controller. More info about this will be added later.

## Contributing

The usual stuff. Open an issue to discuss a change, open pull requests directly for bugfixes and refactors.
