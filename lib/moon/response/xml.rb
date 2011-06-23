require 'xmlsimple'

# Moon::Response::XML is the base class for all xml responses.
class Moon::Response::XML < Moon::Response::Base

  attr_accessor :status
  attr_accessor :hash

  def initialize(status, root_tag, hash = { })
    @status, @root_tag, @hash = status, root_tag, hash
  end

  def headers
    { "Content-Type" => "text/xml" }
  end

  def body
    XmlSimple.xml_out @hash, "RootName" => @root_tag, "XmlDeclaration" => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
  end

end
