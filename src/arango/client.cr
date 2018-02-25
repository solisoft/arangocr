class Arango::Client
  setter :async

  def initialize(@endpoint : String, @user : String, @password : String)
    @jwt = ""
    uri = URI.parse("#{@endpoint}")
    @http = HTTP::Client.new uri
    @async = false
    response = @http.post(
      "/_open/auth",
      body: {"username" => @user, "password" => @password}.to_json
    )
    if response.status_code == 200
      @jwt = JSON.parse(response.body)["jwt"].to_s
    elsif response.status_code == 404
      puts "Warning! It looks like you are using a passwordless configuration!"
    else
      puts "Error #{response.status_code} #{response.status_message}"
    end
  end

  def database(name : String)
    Database.new(self, name)
  end

  def get(url : String)
    response = @http.get(url, headers)
    JSON.parse(response.body)
  end

  def post(url : String, body : Hash | Array)
    response = @http.post(url, headers: headers, body: body.to_json)
    JSON.parse(response.body)
  end

  def post(url : String, body : String)
    response = @http.post(url, headers: headers, body: body)
    JSON.parse(response.body)
  end

  def post(url : String)
    response = @http.post(url, headers: headers)
    JSON.parse(response.body)
  end

  def patch(url : String, body : Hash | Array)
    response = @http.patch(url, headers: headers, body: body.to_json)
    JSON.parse(response.body)
  end

  def patch(url : String, body : String)
    response = @http.patch(url, headers: headers, body: body)
    JSON.parse(response.body)
  end

  def delete(url : String)
    response = @http.delete(url, headers: headers)
    response.body == "" ? {"code" => response.status_code} : JSON.parse(response.body)
  end

  def delete(url : String, body : Hash)
    response = @http.delete(url, headers: headers, body: body.to_json)
    JSON.parse(response.body)
  end

  def put(url : String, body : Hash | Array)
    response = @http.put(url, headers: headers, body: body.to_json)
    JSON.parse(response.body)
  end

  def put(url : String, body : String)
    response = @http.put(url, headers: headers, body: body)
    JSON.parse(response.body)
  end

  def head(url : String)
    response = @http.head(url, headers: headers)
    JSON.parse(response.body)
  end

  private def headers
    if @async
      HTTP::Headers{"Authorization" => "bearer #{@jwt}", "x-arango-async" => "true"}
    else
      HTTP::Headers{"Authorization" => "bearer #{@jwt}"}
    end
  end
end
