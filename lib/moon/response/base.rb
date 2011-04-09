
# Moon::Response::Base is the base class for all responses. It simply provides default values
# for status, headers and body
class Moon::Response::Base

  def status
    200
  end

  def headers
    { }
  end

  def body
    nil
  end

end
