
class Post

  attr_accessor :title

end

Given /^the post resources route$/ do
  application.configure do
    route {
      http_method :post
      path "/posts"
      actions Moon::Action::Models::Initializer,
              Moon::Action::ValidModelsRequired,
              Moon::Action::RespondBlank.new
    }
    validator {
      model_class Post
      attributes {
        title Moon::Validator::Presence.new
      }
    }
  end
end

Given /^valid post parameters$/ do
  @current_parameters = {
    :post => { :title => "test" }
  }
end

Given /^invalid post parameters$/ do
  @current_parameters = {
    :post => { :title => "" }
  }
end

When /^the post is created$/ do
  post "/posts", @current_parameters
end
