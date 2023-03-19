require "spec_helper"

RSpec.describe OpenLibrary::Client do
  let(:client) { OpenLibrary::Client.new }

  describe "#search" do
    it "returns search results for a valid query" do
      results = client.search("The Catcher in the Rye")
      expect(results).to be_a(Hash)
      expect(results["docs"]).to be_an(Array)
      expect(results["docs"].size).to be > 0
    end

    it "returns an empty result for an invalid query" do
      results = client.search("nonexistentbookquery")
      expect(results).to be_a(Hash)
      expect(results["docs"]).to be_empty
    end
  end

  describe "#get_work" do
    it "returns work details for a valid work ID" do
      work = client.get_work("OL2707183W")
      expect(work).to be_a(Hash)
      expect(work["title"]).to eq("Assassin's Apprentice")
    end

    it "raises an error for an invalid work ID" do
      expect { client.get_work("INVALID_WORK_ID") }.to raise_error(OpenLibrary::Error)
    end
  end

  describe "#get_covers" do
    it "returns cover images for a valid work ID" do
      covers = client.get_covers("OL2707183W")
      expect(covers).to be_an(Array)
      expect(covers.size).to be > 0
    end

    it "raises an error for an invalid work ID" do
      expect { client.get_covers("INVALID_WORK_ID") }.to raise_error(OpenLibrary::Error)
    end
  end

  describe "#get_author" do
    it "returns author details for a valid author ID" do
      author = client.get_author("OL395837A")
      expect(author).to be_a(Hash)
      expect(author["name"]).to eq("Robin Hobb")
    end

    it "raises an error for an invalid author ID" do
      expect { client.get_author("INVALID_AUTHOR_ID") }.to raise_error(OpenLibrary::Error)
    end
  end
end
