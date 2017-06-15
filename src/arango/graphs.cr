require "./client"

class Arango::Graph
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String, @name : String); end

  def all
    @client.get("/_db/#{@database}/_api/gharial")
  end

  def get(name : String)
    @client.get("/_db/#{@database}/_api/gharial/#{name}")
  end

  def create(body : Hash | Array)
    @client.post("/_db/#{@database}/_api/gharial", body)
  end

  def delete(name : String)
    @client.delete("/_db/#{@database}/_api/gharial/#{@name}")
  end

  def vertex_collection
    VertexCollection.new(@client, @database, @name)
  end

  def vertex(collection)
    Vertex.new(@client, @database, @name, collection)
  end

  def edge_definition
    EdgeDefinition.new(@client, @database, @name)
  end

  def edge(definition)
    Edge.new(@client, @database, @name, definition)
  end
end
