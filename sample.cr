require "./src/*"

client = Arango::Client.new("http://127.0.0.1:8529", "root", "")
database = client.database("demo3")

puts "\nCurrent Database"
puts database.current

puts "All Databases"
puts database.all

demo = database.collection("demo")

puts database.foxx.install("/auth", "/Users/olivier/workspace/demo/foxxy_shop/foxx/_appbundles/auth.zip")

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
