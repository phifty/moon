
class TestAction

  def perform(context)
    Moon::Response::Base.new
  end

end

Given /^the test route$/ do
  application.configure do
    route {
      http_method :get
      path "/test"
      actions TestAction.new
    }
  end
end

When /^the test route is called$/ do
  get "/test"
end
