class Arango::Client
  def initialize(@endpoint : String, @user : String,
                 @password : String, @database : String)
    @jwt = ""
    uri = URI.parse("#{@endpoint}")
    @http = HTTP::Client.new uri
    response = @http.post_form(
      "/_open/auth",
      {"username" => @user, "password" => @password}.to_json
    )
    if response.status_code == 200
      @jwt = JSON.parse(response.body)["jwt"].to_s
    else
      puts "Error #{response.status_code} #{response.status_message}"
    end
  end

  def database
    Database.new(self, @database)
  end

  def get(url : String)
    response = @http.get(
      url,
      HTTP::Headers{"Authorization" => "bearer #{@jwt}"}
    )
    JSON.parse(response.body)
  end

  def post(url : String, body : Hash)
    response = @http.post(
      url,
      headers: HTTP::Headers{"Authorization" => "bearer #{@jwt}"},
      body: body.to_json
    )
    puts response.body
    JSON.parse(response.body)
  end

  def patch(url : String, body : Hash)
    response = @http.patch(
      url,
      headers: HTTP::Headers{"Authorization" => "bearer #{@jwt}"},
      body: body.to_json
    )
    JSON.parse(response.body)
  end

  def delete(url : String)
    response = @http.delete(
      url,
      headers: HTTP::Headers{"Authorization" => "bearer #{@jwt}"}
    )
    JSON.parse(response.body)
  end

  def delete(url : String, body : Hash)
    response = @http.delete(
      url,
      headers: HTTP::Headers{"Authorization" => "bearer #{@jwt}"},
      body: body.to_json
    )
    JSON.parse(response.body)
  end

  def put(url : String, body : Hash)
    response = @http.put(
      url,
      headers: HTTP::Headers{"Authorization" => "bearer #{@jwt}"},
      body: body.to_json
    )
    JSON.parse(response.body)
  end

  def head(url : String)
    response = @http.head(
      url,
      headers: HTTP::Headers{"Authorization" => "bearer #{@jwt}"}
    )
    JSON.parse(response.body)
  end
end
