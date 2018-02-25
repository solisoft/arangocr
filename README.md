# Arangocr

This library provides binding for ArangoDB HTTP interface

## Status

v0.1.0

## Requirements

* Crystal language version 0.20 and higher

## Installation

Add this to your application's `shard.yml`

````yaml
dependencies:
  arangocr:
    github: solisoft/arangocr
    branch: master
````

## Usage

````crystal
require "arangocr"

client = Arango::Client.new("http://127.0.0.1:8529", "root", "")
database = client.database("demo3")

puts "All Databases"
puts database.all

puts "\nCurrent Database"
puts database.current

demo = database.collection("demo")

puts "\nInsert one document"
data = [] of Hash(String, String)
(1..100).each do |i|
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

# puts aql.all({"query" => "FOR d IN demo RETURN d"}).size

puts aql.cursor({"query" => "FOR d IN demo LIMIT 5 RETURN d"})

puts "\nTransaction"
puts database.transaction.execute({"collections" => {"write" => "demo"},
                                   "action"      => "function () { var db = require('@arangodb').db; db.demo.save({});  return db.demo.count(); }"})


puts "\nTruncate collection demo"
puts demo.truncate

puts "\nDelete collection demo"
puts demo.delete

puts "\nDelete database"
puts database.delete

````

Will provide this output
````
Current Database
{"error" => false, "code" => 200_i64, "result" => {"name" => "demo3", "id" => "34472968", "path" => "/usr/local/var/lib/arangodb3", "isSystem" => false}}
All Databases
{"error" => false, "code" => 200_i64, "result" => ["_system", "airbus", "avenircours", "batitel", "cms_bw", "cms_localhost", "dc", "defy2", "defycards", "demo", "demo2", "demo3", "lgc", "shop", "telegraphe", "test", "thebrane"]}

Insert one document

Read all Keys

Run AQL query (cursor)
100
{"result" => [{"_key" => "34473018", "_id" => "demo/34473018", "_rev" => "_WYZ1pVS--_", "fn" => "1 Olivier", "ln" => "1 BONNAURE"}, {"_key" => "34473019", "_id" => "demo/34473019", "_rev" => "_WYZ1pVW--_", "fn" => "2 Olivier", "ln" => "2 BONNAURE"}, {"_key" => "34473033", "_id" => "demo/34473033", "_rev" => "_WYZ1pVa--_", "fn" => "14 Olivier", "ln" => "14 BONNAURE"}, {"_key" => "34473053", "_id" => "demo/34473053", "_rev" => "_WYZ1pVe--_", "fn" => "34 Olivier", "ln" => "34 BONNAURE"}, {"_key" => "34473074", "_id" => "demo/34473074", "_rev" => "_WYZ1pVi--_", "fn" => "55 Olivier", "ln" => "55 BONNAURE"}], "hasMore" => false, "cached" => false, "extra" => {"stats" => {"writesExecuted" => 0_i64, "writesIgnored" => 0_i64, "scannedFull" => 5_i64, "scannedIndex" => 0_i64, "filtered" => 0_i64, "httpRequests" => 0_i64, "executionTime" => 0.0006010532379150391}, "warnings" => []}, "error" => false, "code" => 201_i64}

Transaction
{"error" => false, "code" => 200_i64, "result" => 101_i64}

Truncate collection demo
{"code" => 200_i64, "error" => false, "type" => 2_i64, "status" => 3_i64, "name" => "demo", "isSystem" => false, "id" => "34473010", "globallyUniqueId" => "h4ACB4C97B13C/34473010"}

Delete collection demo
{"code" => 200_i64, "error" => false, "id" => "34473010"}

Delete database
{"error" => false, "code" => 200_i64, "result" => true}
````

## Todos

* Add more samples about documents
* Add more samples about AQL cursors
* Add tests

## Licence

MIT clause