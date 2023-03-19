require 'httparty'
require 'json'

module OpenLibrary
  class Client
    include HTTParty
    base_uri 'https://openlibrary.org'

    def search(query, page = 1)
      response = self.class.get('/search.json', query: { q: query, page: page })
      JSON.parse(response.body)
    end

    def get_work(work_id)
      response = self.class.get("/works/#{work_id}.json")
      JSON.parse(response.body)
    end

    def get_covers(work_id)
      response = self.class.get("/works/#{work_id}.json")
      JSON.parse(response.body)['covers']
    end

    def get_author(author_id)
      response = self.class.get("/authors/#{author_id}.json")
      JSON.parse(response.body)
    end
  end
end
