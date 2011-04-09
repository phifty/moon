require 'json'

# Moon::Response::JSON is the base class for all json responses.
class Moon::Response::JSON < Moon::Response::Base

  autoload :Collection, File.join(File.dirname(__FILE__), "json", "collection")
  autoload :Message, File.join(File.dirname(__FILE__), "json", "message")
  autoload :Model, File.join(File.dirname(__FILE__), "json", "model")
  autoload :ValidationErrors, File.join(File.dirname(__FILE__), "json", "validation_errors")

  attr_accessor :status
  attr_accessor :hash

  def initialize(status, hash = { })
    @status, @hash = status, hash
  end

  def headers
    { "Content-Type" => "application/json" }
  end

  def body
    ::JSON.generate hash
  end

end
