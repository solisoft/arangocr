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

client = Arango::Client.new("http://127.0.0.1:8529", "root", "", "mydatabase")
database = client.database

puts "All Databases"
puts "-------------"
puts database.all

puts "\nCurrent Database"
puts "------------------"
puts database.current

puts "\nCreate Database demoXYZ-123456789"
puts "-----------------------------------"
puts database.create({"name" => "demoXYZ-123456789"})

puts "\nDelete Database demoXYZ-123456789"
puts "-----------------------------------"
puts database.delete("demoXYZ-123456789")

collection = client.collection
puts "\nCreate collection demo"
puts "------------------------"
puts collection.create({"name" => "demo"})

puts "\nTruncate collection demo"
puts "--------------------------"
puts collection.truncate("demo")

puts "\nDelete collection demo"
puts "------------------------"
puts collection.delete("demo")
````

## Todos

* Add more samples about documents
* Add more samples about AQL cursors
* Add tests

## Licence

MIT clause