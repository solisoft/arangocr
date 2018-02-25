require "./client"

class Arango::Collection
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String, @name : String)
    create if status["code"] == 404
  end

  def status
    @client.get("/_db/#{@database}/_api/#{@name}")
  end

  protected def create
    @client.post("/_db/#{@database}/_api/collection", {"name" => @name})
  end

  def delete
    @client.delete("/_db/#{@database}/_api/collection/#{@name}")
  end

  def truncate
    @client.put("/_db/#{@database}/_api/collection/#{@name}/truncate", {} of String => String)
  end

  def infos
    @client.get("/_db/#{@database}/_api/collection/#{@name}")
  end

  def properties
    @client.get("/_db/#{@database}/_api/collection/#{@name}/properties")
  end

  def count
    @client.get("/_db/#{@database}/_api/collection/#{@name}/count")
  end

  def figures
    @client.get("/_db/#{@database}/_api/collection/#{@name}/figures")
  end

  def revision
    @client.get("/_db/#{@database}/_api/collection/#{@name}/revision")
  end

  def checksum
    @client.get("/_db/#{@database}/_api/collection/#{@name}/checksum")
  end

  def all
    @client.get("/_db/#{@database}/_api/collection")
  end

  def all_keys(_type = "path")
    @client.put("/_db/#{@database}/_api/simple/all-keys", {"collection" => @name, "type" => _type})
  end

  def load
    @client.put("/_db/#{@database}/_api/collection/#{@name}/load", {} of String => String)
  end

  def unload
    @client.put("/_db/#{@database}/_api/collection/#{@name}/unload", {} of String => String)
  end

  def update_properties(body : Hash)
    @client.put("/_db/#{@database}/_api/collection/#{@name}/unload", body)
  end

  def rename(new_name : String)
    @client.put("/_db/#{@database}/_api/collection/#{@name}/rename", {"name" => new_name})
  end

  def rotate
    @client.put("/_db/#{@database}/_api/collection/#{@name}/rotate", {} of String => String)
  end

  def document
    Document.new(@client, @database, @name)
  end
end
