require "./client"

class Arango::Database
  @client : Arango::Client

  getter client, database

  def initialize(@client, @database : String)
    create if current["code"] == 404
  end

  protected def create
    client.post("/_api/database", {"name" => database})
  end

  def all
    client.get("/_db/#{database}/_api/database/user")
  end

  def current
    client.get("/_db/#{database}/_api/database/current")
  end

  def delete
    client.delete("/_api/database/#{database}")
  end

  def [](name)
    collection(name)
  end

  def collection(name)
    Collection.new(client, database, name)
  end

  def aql
    Aql.new(@client, database)
  end

  def transaction
    Transaction.new(@client, database)
  end

end
