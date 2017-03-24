require "./client"

class Arango::Collection
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String); end

  def create(body : Hash)
    @client.post("/_db/#{@database}/_api/collection", body)
  end

  def delete(name : String)
    @client.delete("/_db/#{@database}/_api/collection/#{name}")
  end

  def truncate(name : String)
    @client.put("/_db/#{@database}/_api/collection/#{name}/truncate", {} of String => String)
  end

  def infos(name : String)
    @client.get("/_db/#{@database}/_api/collection/#{name}")
  end

  def properties(name : String)
    @client.get("/_db/#{@database}/_api/collection/#{name}/properties")
  end

  def count(name : String)
    @client.get("/_db/#{@database}/_api/collection/#{name}/count")
  end

  def figures
    @client.get("/_db/#{@database}/_api/collection/#{name}/figures")
  end

  def revision
    @client.get("/_db/#{@database}/_api/collection/#{name}/revision")
  end

  def checksum
    @client.get("/_db/#{@database}/_api/collection/#{name}/checksum")
  end

  def all
    @client.get("/_db/#{@database}/_api/collection")
  end

  def load(name : String)
    @client.put("/_db/#{@database}/_api/collection/#{name}/load", {} of String => String)
  end

  def unload(name : String)
    @client.put("/_db/#{@database}/_api/collection/#{name}/unload", {} of String => String)
  end

  def update_properties(name : String, body : Hash)
    @client.put("/_db/#{@database}/_api/collection/#{name}/unload", body)
  end

  def rename(name : String, new_name : String)
    @client.put("/_db/#{@database}/_api/collection/#{name}/rename", {"name" => new_name})
  end

  def rotate(name : String)
    @client.put("/_db/#{@database}/_api/collection/#{name}/rotate", {} of String => String)
  end

  def document(collection : String)
    Document.new(@client, @database, collection)
  end
end
