require "./spec_helper"

client = Arango::Client.new("http://127.0.0.1:8529", "root", "")
database = client.database("test_arangocr")

describe Arangocr do
  # TODO: Write tests

  it "Should return the right db name" do
    database.current["result"]["name"].should eq("test_arangocr")
  end

  it "Should create the collection" do
    demo = database.collection("demo")
    demo.should be_a(Arango::Collection)
  end

  it "Should Insert a value" do
    demo = database.collection("demo")
    obj = demo.document.create({ "hello" => "world" })
    obj["_id"].should be_a(JSON::Any)
  end

  it "Should read all documents" do
    demo = database.collection("demo")
    demo.all_documents["result"].size.should eq 1
  end


end

database.delete