class Response

  attr_accessor :body, :code, :headers

  def initialize(body, code = nil)
    @body = body
    @code = code
    @headers = {"Content-Type" => "application/json; charset=utf-8"}
  end

  def [](key)
    if key.instance_of?(String)
       "application/json; charset=utf-8"
    else
       "not string"
    end
    "application/json; charset=utf-8"
  end

end