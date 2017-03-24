require "./client"

class Arango::Database
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String); end

  def all
    @client.get("/_db/#{@database}/_api/database/user")
  end

  def current
    @client.get("/_db/#{@database}/_api/database/current")
  end

  def create(body : Hash)
    @client.post("/_api/database", body)
  end

  def delete(name : String)
    @client.delete("/_api/database/#{name}")
  end
end
