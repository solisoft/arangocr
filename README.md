# Arangocr

This library provides binding for ArangoDB HTTP interface

## Status

alpha

## Requirements

* Crystal language version 0.20 and higher

## Installation

Add this to your application's `shard.yml`

````yaml
arango:
  github: solisoft/arangocr
  branch: master
````

## Usage

````crystal
require "arango"

client = Arango::Client.new("http://127.0.0.1:8529", "root", "", "demo")
database = client.database
puts "All Databases"
puts database.all

puts "\nCurrent Database"
puts database.current

puts "\nCreate Database demoXYZ-123456789"
puts database.create({"name" => "demoXYZ-123456789"})

puts "\nDelete Database demoXYZ-123456789"
puts database.delete("demoXYZ-123456789")

demo = database.collection("demo")
puts "\nCreate collection demo"
puts demo.create({"name" => "demo"})

puts "\nInsert one document"
data = [] of Hash(String, String)
(1..100000).each do |i|
  data.push({"fn" => "#{i} Olivier", "ln" => "#{i} BONNAURE"})
end
demo.document.create(data)

puts "\nRead all Keys"
demo.all_keys

puts "\nRun AQL query (cursor)"
aql = database.aql
cursor = aql.cursor({"query" => "FOR d IN demo RETURN d"})
puts cursor["result"].size
while (cursor["hasMore"] == true)
  cursor = aql.next(cursor["id"].to_s)
  puts cursor["result"].size
end

puts "\nTruncate collection demo"
puts demo.truncate

puts "\nDelete collection demo"
puts demo.delete
````

Will provide this output
````
All Databases
{"result" => ["_system", "akelpri", "anonsotop", "batitel", "bloggy", "cms_cms", "dc", "defycards", "demo", "dsn", "eshop", "jwtdemo", "mydemo", "plugandwork", "rce", "renault", "thebrane", "time"], "error" => false, "code" => 200}

Current Database
{"result" => {"name" => "demo", "id" => "1315548", "path" => "/usr/local/var/lib/arangodb3/databases/database-1315548", "isSystem" => false}, "error" => false, "code" => 200}

Create Database demoXYZ-123456789
{"result":true,"error":false,"code":201}
{"result" => true, "error" => false, "code" => 201}

Delete Database demoXYZ-123456789
{"result" => true, "error" => false, "code" => 200}

Create collection demo
{"id":"59683047","name":"demo","waitForSync":false,"isVolatile":false,"isSystem":false,"status":3,"type":2,"error":false,"code":200}
{"id" => "59683047", "name" => "demo", "waitForSync" => false, "isVolatile" => false, "isSystem" => false, "status" => 3, "type" => 2, "error" => false, "code" => 200}

Insert one document
[{"_id":"demo/59683050","_key":"59683050","_rev":"_UxElb9y---"},{"_id":"demo/59683054","_key":"59683054","_rev":"_UxElb9y--_"}]

Read all Keys

Run AQL query (cursor)
{"result":[{"_key":"59683050","_id":"demo/59683050","_rev":"_UxElb9y---","fn":"Olivier","ln":"BONNAURE"},{"_key":"59683054","_id":"demo/59683054","_rev":"_UxElb9y--_","fn":"Sophie","ln":"BONNAURE"}],"hasMore":false,"cached":false,"extra":{"stats":{"writesExecuted":0,"writesIgnored":0,"scannedFull":2,"scannedIndex":0,"filtered":0,"executionTime":1.590251922607422e-4},"warnings":[]},"error":false,"code":201}

Truncate collection demo
{"id" => "59683047", "name" => "demo", "isSystem" => false, "status" => 3, "type" => 2, "error" => false, "code" => 200}

Delete collection demo
{"id" => "59683047", "error" => false, "code" => 200}
````

## Todos

* Add more samples about documents
* Add more samples about AQL cursors
* Add tests

## Licence

MIT clause