require "./client"

class Arango::Vertex
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String, @graph : String); end

  def create(name : String, body : Hash | Array)
    @client.post("/_db/#{@database}/_api/gharial/#{@graph}/vertex/#{name}", body)
  end

  def update(name : String, body : Hash | Array)
    @client.patch("/_db/#{@database}/_api/gharial/#{@graph}/vertex/#{name}", body)
  end

  def replace(name : String, body : Hash | Array)
    @client.put("/_db/#{@database}/_api/gharial/#{@graph}/vertex/#{name}", body)
  end

  def delete(name : String)
    @client.delete("/_db/#{@database}/_api/gharial/#{@graph}/vertex/#{name}")
  end
end
