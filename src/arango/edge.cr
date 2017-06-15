require "./client"

class Arango::Edge
  @client : Arango::Client

  getter client

  def initialize(@client, @database : String, @graph : String, @definition : String); end

  def create(body : Hash | Array)
    @client.post("/_db/#{@database}/_api/gharial/#{@graph}/edge/#{@definition}", body)
  end

  def update(key : String, body : Hash | Array)
    @client.patch("/_db/#{@database}/_api/gharial/#{@graph}/edge/#{@definition}/#{key}", body)
  end

  def replace(key : String, body : Hash | Array)
    @client.put("/_db/#{@database}/_api/gharial/#{@graph}/edge/#{@definition}/#{key}", body)
  end

  def delete(key : String)
    @client.delete("/_db/#{@database}/_api/gharial/#{@graph}/edge/#{@definition}/#{key}")
  end
end
