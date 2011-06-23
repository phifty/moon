
class Post

  attr_accessor :title

end

class PostFormatter

  def hash(model)
    {
      :id => nil,
      :title => model.title,
      :timestamp => "now"
    }
  end

end

Given /^the create post resource route$/ do
  application.configure do
    session {
      secret "test"
    }
    route {
      http_method :post
      path "/posts"
      actions Moon::Action::Models::Initializer.new,
              Moon::Action::ValidModelsRequired.new,
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

Given /^the show post resource route$/ do
  application.configure do
    session {
      secret "test"
    }
    route {
      http_method :get
      path "/posts/1"
      actions Moon::Action::Models::Initializer.new,
              Moon::Action::Model::Show.new(:post)
    }
    formatter {
      model_class Post
      object PostFormatter.new
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

When /^the create post is called$/ do
  post "/posts", @current_parameters
end

When /^the show post is called$/ do
  get "/posts/1", @current_parameters
end
