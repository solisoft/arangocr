require "./client"

class Arango::EdgeDefinition
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String, @graph : String); end

  def all(id : String)
    @client.get("/_db/#{@database}/_api/gharial/#{@graph}/edge")
  end

  def create(body : Hash | Array)
    @client.post("/_db/#{@database}/_api/gharial/#{@graph}/edge", body)
  end

  def replace(name : String, body : Hash | Array)
    @client.put("/_db/#{@database}/_api/gharial/#{@graph}/edge/#{name}", body)
  end

  def delete(name : String)
    @client.delete("/_db/#{@database}/_api/gharial/#{@graph}/edge/#{name}")
  end
end
