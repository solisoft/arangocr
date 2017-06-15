require "./client"

class Arango::VertexCollection
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String, @graph : String); end

  def all(id : String)
    @client.get("/_db/#{@database}/_api/gharial/#{@graph}/vertex")
  end

  def create(body : Hash | Array)
    @client.post("/_db/#{@database}/_api/gharial/#{@graph}/vertex", body)
  end

  def delete(name : String)
    @client.delete("/_db/#{@database}/_api/gharial/#{@graph}/vertex/#{name}")
  end
end
