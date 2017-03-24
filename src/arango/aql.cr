require "./client"

class Arango::Aql
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String); end

  def cursor(body : Hash)
    @client.post("/_db/#{@database}/_api/cursor", body)
  end

  def next(id : String)
    @client.put("/_db/#{@database}/_api/cursor/#{id}", {} of String => String)
  end

  def clear_cache
    @client.delete("/_db/#{@database}/_api/query-cache")
  end

  def cache_properties
    @client.get("/_db/#{@database}/_api/query-cache/properties")
  end

  def adjust_cache(body : Hash)
    @client.put("/_db/#{@database}/_api/query-cache/properties", body)
  end
end
